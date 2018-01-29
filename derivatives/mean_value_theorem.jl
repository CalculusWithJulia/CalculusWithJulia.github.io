module mean_value_theorem


using WeavePynb, LaTeXStrings
using Plots
#gr()
pyplot()
fig_size = (600, 400)


function parametric_fns_graph(n)
    f = (x) -> sin(x)
    g = (x) -> x

    ns = (1:10)/10
    ts = linspace(-pi/2, -pi/2 + ns[n] * pi)

    plt = plot(f, g, -pi/2, -pi/2 + ns[n] * pi, legend=false, size=fig_size,
               xlim=(-1.1,1.1), ylim=(-pi/2-.1, pi/2+.1))
    scatter!(plt, [f(ts[end])], [g(ts[end])], color=:orange, markersize=5)
    val = @sprintf("% 0.2f", ts[end])
    annotate!(plt, [(0, 1, "t = $val")])
end
caption = L"""

Illustration of parametric graph of $(g(t), f(t))$ for $-\pi/2 \leq t
\leq \pi/2$ with $g(x) = \sin(x)$ and  $f(x) = x$. Each point on the
graph is from some value $t$ in the interval. We can see that the
graph goes through $(0,0)$ as that is when $t=0$. As well, it must go
through $(1, \pi/2)$ as that is when $t=\pi/2$

"""


n = 10
anim = @animate for i=1:n
    parametric_fns_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

parametric_fns = gif_to_data(imgfile, caption)

## ---------------



lhopital_32 = gif_to_data("./lhopital-32.png", L"""

Image number 32 from L'Hopitals calculus book (the first) showing that
at a relative minimum, the tangent line is parallel to the
$x$-axis. This of course is true when the tangent line is well defined
by Fermat's observation.


""")



end
