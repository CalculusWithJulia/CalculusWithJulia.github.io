module related_rates

using WeavePynb, LaTeXStrings
using Gadfly, Reel, Mustache



## Secant line approaches tangent line...
function growing_rects_graph(n, dt)
    w(t) = 2 + 4t
    h(t) = 3/2 * w(t)
    t = n = convert(Int, n)

    w_2 = w(t)/2
    h_2 = h(t)/2

    w_n = w(5)/2
    h_n = h(5)/2

    plot(layer(x=w_2 * [-1, -1, 1, 1, -1], y = h_2 * [-1, 1, 1, -1, -1], Geom.line(preserve_order=true)),
         layer(x=[-1.5], y=[1], label=["Area = $(round(Int, 4*w_2*h_2))"], Geom.label),
         Guide.xticks(ticks=[-w_n, 0, w_n]),
         Guide.yticks(ticks=[-h_n, 0, h_n])
         )

    
end
caption = L"""

As $t$ increases, the size of the rectangle grows. The ratio of width to height is fixed. If we know the rate of change in time for the width ($dw/dt$) and the height ($dh/dt$) can we tell the rate of change of *area* with respect to time ($dA/dt$)?

"""

film = roll(growing_rects_graph, fps=1, duration=7)
film.fps=1/2


imgfile = tempname() * ".gif"
write(imgfile, film)
growing_rects = gif_to_data(imgfile, caption)


#####

## Secant line approaches tangent line...
function baseball_been_berry_good_graph(n, dt)

    v0 = 15
    x(t) = 50t
    y(t) = v0*t - 5 * t^2

    
    ns = linspace(.25, 3, 8)

    n = convert(Int, n) + 1
    t = ns[n]
    ts = linspace(0, t)
    xs = map(x, ts)
    ys = map(y, ts)

    degrees = atand(y(t)/(100-x(t)))
    degrees = degrees < 0 ? 180 + degrees : degrees
    
    plot(layer(x=xs, y=ys, Geom.line),
         layer(x=[x(t), 100], y=[y(t), 0.0], Geom.line, Theme(default_color=color("orange"))),
         layer(x=[55], y=[4], label=["theta = $(round(Int, degrees)) degrees"], Geom.label),
         layer(x=[x(t)], y=[y(t)], label=["($(round(Int, x(t))), $(round(Int, y(t))))"], Geom.label),
         Guide.xticks(ticks=[0,50, 100, x(3)]),
         Guide.yticks(ticks=[0,5,10,15])
         )
    
end
caption = L"""

The flight of the ball as being tracked by a stationary outfielder.  This ball will go over the head of the player. What can the player tell from the quantity $d\theta/dt$?

"""

film = roll(baseball_been_berry_good_graph, fps=1, duration=8)
film.fps=1/2


imgfile = tempname() * ".gif"
write(imgfile, film)
baseball_been_berry_good = gif_to_data(imgfile, caption)



end
