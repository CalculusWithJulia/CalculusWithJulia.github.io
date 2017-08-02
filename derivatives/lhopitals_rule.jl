module lhopitals_rule


using WeavePynb, LaTeXStrings
using Roots

using Plots
gr()
fig_size=(600, 400)


function lhopitals_picture_graph(n)
    
    g = (x) -> sqrt(1 + x) - 1 - x^2
    f = (x) -> x^2
    ts = linspace(-1/2, 1/2)

    
    a, b = 0, 1/2^n * 1/2
    m = (f(b)-f(a)) /  (g(b)-g(a)) 
    
    ## get bounds
    tl = (x) -> g(0) + m * (x - f(0))
    
    lx = max(fzero(x -> tl(x) - (-0.05),-1000, 1000), -0.6)
    rx = min(fzero(x -> tl(x) - (0.25),-1000, 1000), 0.2)
    xs = [lx, rx]
    ys = map(tl, xs)

    plt = plot(g, f, -1/2, 1/2, legend=false, size=fig_size, xlim=(-.6, .5), ylim=(-.1, .3))
    plot!(plt, xs, ys, color=:orange)
    scatter!(plt, [g(a),g(b)], [f(a),f(b)], markersize=5, color=:orange)
    plt
end

caption = L"""

Geometric interpretation of $L=\lim_{x \rightarrow 0} x^2 / (\sqrt{1 +
x} - 1 - x^2)$. At $0$ this limit is indeterminate of the form
$0/0$. The value for a fixed $x$ can be seen as the slope of a secant
line of a parametric plot of the two functions, plotted as $(g,
f)$. In this figure, the limiting "tangent" line has $0$ slope,
corresponding to the limit $L$. In general, L'Hospital's rule is
nothing more than a statement about slopes of tangent lines.

"""

n = 6
anim = @animate for i=1:n
    lhopitals_picture_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

lhopitals_picture = gif_to_data(imgfile, caption)







end
