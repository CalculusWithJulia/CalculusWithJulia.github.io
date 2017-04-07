module ftc
using WeavePynb, LaTeXStrings
using Plots
pyplot()
fig_size = (400, 400)

function make_ftc_graph(n)
    a, b = 2, 3
    ts = linspace(0, b)
    xs = linspace(a,b,8)
    g(x) = x
    G(x) = x^2/2

    xn,xn1 = xs[n:(n+1)]
    xbar = (xn+xn1)/2
    rxs = collect(linspace(xn, xn1, 2))
    rys = map(g, rxs)

    p = plot(g, 0, b, legend=false, size=fig_size, xlim=(0,3.25), ylim=(0,5))
    plot!(p, [xn, rxs..., xn1], [0,rys...,0], linetype=:polygon, color=:orange)
    plot!(p, [xn1, xn1], [G(xn), G(xn1)], color=:orange, alpha = 0.25)
    annotate!(p, collect(zip([xn1, xn1], [G(xn1)/2, G(xn1)], ["A", "A"])))

    p
end

caption = L"""

Illustration showing $F(x) = \int_a^x f(u) du$ is a function that
accumulates area. The value of $A$ is the area over $[x_{n-1}, x_n]$
and also the difference $F(x_n) - F(x_{n-1})$.

"""

n = 7

anim = @animate for i=1:n
    make_ftc_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

ftc_graph = gif_to_data(imgfile, caption)

#####
# using Gadfly, Reel

# function make_ftc_graph(n,_)
#     n = convert(Int, n) + 1

#     a, b = 2, 3
#     ts = linspace(0, b)
#     xs = linspace(a,b,8)
#     g(x) = x
#     G(x) = x^2/2

#     xn,xn1 = xs[n:(n+1)]
#     xbar = (xn+xn1)/2
#     rxs = [linspace(xn, xn1, 2)]
#     rys = map(g, rxs)
    
#     plot(layer(x=ts, y=map(g, ts), Geom.line),
#          layer(x=ts, y=map(G, ts), Geom.line, Theme(default_color=color("red"))),
#          layer(x=[xn, rxs..., xn1],y=[0,rys...,0], Geom.polygon(preserve_order=true, fill=true), Theme(default_color=color("orange"))),
#          layer(x=[xn1, xn1], y=[G(xn), G(xn1)], Geom.line, Theme(default_color=color("orange"),panel_opacity=0.25)),
#          layer(x=[xn1, xn1], y=[G(xn1)/2, G(xn1)], label=["A", "A"], Geom.label)
#          )
# end

# film = roll(make_ftc_graph, fps=1, duration=7)
# film.fps=1
# imgfile = tempname() * ".gif"
# write(imgfile, film)

# caption = L"""

# Illustration showing $F(x) = \int_a^x f(u) du$ is a function that
# accumulates area. The value of $A$ is the area over $[x_{n-1}, x_n]$
# and also the difference $F(x_n) - F(x_{n-1})$.

# """

# ftc_graph = gif_to_data(imgfile, caption)


end
