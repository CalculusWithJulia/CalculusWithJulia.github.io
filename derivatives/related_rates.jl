module related_rates

using WeavePynb, LaTeXStrings
using Plots
#gr()
pyplot()
fig_size=(600, 400)



## Secant line approaches tangent line...
function growing_rects_graph(n)
    w = (t) -> 2 + 4t
    h = (t) -> 3/2 * w(t)
    t = n - 1

    w_2 = w(t)/2
    h_2 = h(t)/2

    w_n = w(5)/2
    h_n = h(5)/2

    plt = plot(w_2 * [-1, -1, 1, 1, -1], h_2 * [-1, 1, 1, -1, -1], xlim=(-17,17), ylim=(-17,17),
               legend=false, size=fig_size)
    annotate!(plt, [(-1.5, 1, "Area = $(round(Int, 4*w_2*h_2))")])
    plt
                    
    
end
caption = L"""

As $t$ increases, the size of the rectangle grows. The ratio of width to height is fixed. If we know the rate of change in time for the width ($dw/dt$) and the height ($dh/dt$) can we tell the rate of change of *area* with respect to time ($dA/dt$)?

"""
n=6

anim = @animate for i=1:n
    growing_rects_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)
growing_rects = gif_to_data(imgfile, caption)

## -------------


## Secant line approaches tangent line...
function baseball_been_berry_good_graph(n)

    v0 = 15
    x = (t) -> 50t
    y = (t) -> v0*t - 5 * t^2

    
    ns = linspace(.25, 3, 8)

    t = ns[n]
    ts = linspace(0, t)
    xs = map(x, ts)
    ys = map(y, ts)

    degrees = atand(y(t)/(100-x(t)))
    degrees = degrees < 0 ? 180 + degrees : degrees

    plt = plot(xs, ys, legend=false, size=fig_size, xlim=(0,150), ylim=(0,15))
    plot!(plt, [x(t), 100], [y(t), 0.0], color=:orange)
    annotate!(plt, [(55, 4,"theta = $(round(Int, degrees)) degrees"),
                    (x(t), y(t), "($(round(Int, x(t))), $(round(Int, y(t))))")])
    
end
caption = L"""

The flight of the ball as being tracked by a stationary outfielder.  This ball will go over the head of the player. What can the player tell from the quantity $d\theta/dt$?

"""
n = 8


anim = @animate for i=1:n
    baseball_been_berry_good_graph(i)
end


imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)
baseball_been_berry_good = gif_to_data(imgfile, caption)


end
