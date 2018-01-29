module curve_sketching


using WeavePynb, LaTeXStrings
using Roots

using Plots
#gr()
pyplot()
fig_size=(600, 400)

function sketch_sin_plot_graph(i)
    f(x) = 10*sin(pi/2*x)  # [0,4]
    zs = fzeros(f, 0, 4.1)
    cps = fzeros(D(f), 0, 4)
    xs = linspace(0, 4*(i-2)/6, 50)
    deltax = 1/10
    deltay = 5/10
    if i == 1
        ## plot zeros
        title = "Plot the zeros"
        p = scatter(zs, 0*zs, title=title, xlim=(-deltax,4+deltax), ylim=(-10-deltay,10+deltay), legend=false)
    elseif i == 2
        ## plot extrema
        title = "Plot the local extrema"
        p = scatter(zs, 0*zs, title=title, xlim=(-deltax,4+deltax), ylim=(-10-deltay,10+deltay), legend=false)
        scatter!(p, cps, f.(cps))
    else
        ##  sketch graph
        title = "sketch the graph"
        p = scatter(zs, 0*zs, title=title, xlim=(-deltax,4+deltax), ylim=(-10-deltay,10+deltay), legend=false)
        scatter!(p, cps, f.(cps))
        plot!(p, xs, f.(xs))
    end
    p
end


caption = L"""

After identifying asymptotic behaviours, 
a curve sketch involves identifying the $y$ intercept, if applicable; the $x$ intercepts, if possible; and the local extrema. From there a sketch fills in between the points. In this example, the periodic function $f(x) = 10\cdot\sin(\pi/2\cdot x)$ is sketched over $[0,4]$.

"""



n = 8
anim = @animate for i=1:n
    sketch_sin_plot_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

sketch_sin_plot = gif_to_data(imgfile, caption)


end
