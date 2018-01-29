module derivatives


using WeavePynb, LaTeXStrings
using Plots
#gr()
pyplot()
fig_size=(600, 400)

function secant_line_tangent_line_graph(n)
    f(x) = sin(x)
    c = pi/3
    h = 2.0^(-n) * pi/4
    m = (f(c+h) - f(c))/h
    
    xs = linspace(0, pi)
    plt = plot(f, 0, pi, legend=false, size=fig_size)
    plot!(plt, xs, f(c)+cos(c)*(xs - c), color=:orange)
    plot!(plt, xs, f(c) + m*(xs - c), color=:black)
    scatter!(plt, [c,c+h], [f(c), f(c+h)], color=:orange, markersize=5)

    plot!(plt, [c, c+h, c+h], [f(c), f(c), f(c+h)], color=:gray30)
    annotate!(plt, [(c+h/2, f(c), text("h", :top)), (c + h + .05, (f(c) + f(c + h))/2, text("f(c+h) - f(c)", :left))])
    
    plt
end
caption = L"""

The slope of each secant line represents the *average* rate of change between $c$ and $c+h$. As $h$ goes towards $0$, we recover the slope of the tangent line, which represents the *instantatneous* rate of change.

"""



n = 5
anim = @animate for i=0:n
    secant_line_tangent_line_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

secant_line_tangent_line = gif_to_data(imgfile, caption)


## ------

## best approximates the funciton
function line_approx_fn_graph(n)
    f(x) = sin(x)
    c = pi/3
    h = round(2.0^(-n) * pi/2,2)
    m = cos(c)

    Delta = max(f(c) - f(c-h), f(min(c+h, pi/2)) - f(c))
    
    p = plot(f, c-h, c+h, legend=false, xlims=(c-h,c+h), ylims=(f(c)-Delta,f(c)+Delta ))
    plot!(p, x -> f(c) + m*(x-c))
    scatter!(p, [c], [f(c)])
    p
end
caption = L"""

The tangent line is the best linear approximation to the function at the point $(c, f(c))$. As the viewing window zooms in on $(c,f(c))$ we
    can see how the graph and its tangent line get more similar.

"""

n = 6
anim = @animate for i=1:n
    line_approx_fn_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

line_approx_fn = gif_to_data(imgfile, caption)


end
