module limits

using Gadfly, Reel
using WeavePynb, LaTeXStrings
using Colors

f(x) = x^2
colors = ["black", "blue", "orange", "red", "green", "orange", "purple"]

## Area of parabola

function make_triangle_graph(n,_)
    n = convert(Int, n)
    layers = Layer[]
    xs = linspace(0,1)
    append!(layers, layer(x=xs, y=map(f,xs), Geom.line))

    
    title = "Area of parabolic cup"
    n==1 && (title = "Area = 1/2")
    n==2 && (title = "Area = 1/2 + 2 ⋅ (1/2 ⋅ 1/8)")
    n==3 && (title = "Area = 1/2 + 2 ⋅ (1/2 ⋅ 1/8) + 4 ⋅ (1/2 ⋅ 1/8 ⋅ 1/8)")
    n==4 && (title = "Area = 1/2 + 2 ⋅ (1/2 ⋅ 1/8) + 4 ⋅ (1/2 ⋅ 1/8 ⋅ 1/8) + 8 ⋅ (1/2 ⋅ 1/8 ⋅ 1/8 ⋅ 1/8)")

    if n == 0
        append!(layers, layer(x=[0,0,1],   y=[0,1,1], Geom.line))
    elseif n == 1
        append!(layers, layer(x=[1,0,0,1, 0], y=[1,1,0,1,1], Geom.line(preserve_order=true), Theme(default_color=parse(Colors.Colorant,colors[1]))))
    else    
        for k in (n-1):n
        
            xs = linspace(0,1,1+2^(k-1))
            ys = map(f, xs)
            append!(layers, layer(x=xs, y=ys, Geom.line, Theme(default_color=parse(Colors.Colorant,colors[k]))))
        end
    end
    plot(layers...)
end

film = roll(make_triangle_graph, fps=1, duration=6)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)

caption = L"""

The first triangle has area $1/2$, the second has area $1/8$, then $2$ have area $(1/8)^2$, $4$ have area $(1/8)^3$, ...

With some algebra, the total area then should be $1/2 \cdot (1 + (1/4) + (1/4)^2 + \cdots) = 2/3$.
"""

archimedes_parabola = gif_to_data(imgfile, caption)


## Inscribed area and circumference

function inscribe_polygon(n)
    ts = linspace(0, 2pi, 1000)
    layers = Layer[]

    append!(layers, layer(x = cos(ts), y=sin(ts), Geom.line))

    n = convert(Int, n)
    k = 2^(n+1)
    pts = linspace(0, 2pi, k+1)
    xs = [0.0]
    ys = [0.0]

    for i in 1:k
        append!(xs, cos(pts[i:(i+1)]))
        append!(ys, sin(pts[i:(i+1)]))
    end
    append!(layers, layer(x=xs, y=ys, Geom.line(preserve_order=true)))
    plot(layers...)
end


function make_limit_e_d(n, args...)
    f(x) = x^3
    n = convert(Int, n)

    xs = linspace(-.9, .9)
    ys = map(f, xs)
    

    if n == 0
        plot(layer(x=xs, y=ys, Geom.line))
    else
        k,_ = divrem(n+1,2)
        epsilon = 1/2^k
        delta = cbrt(epsilon)
        layers = Layer[]
        append!(layers, layer(x=xs, y=ys, Geom.line))
        if isodd(n)
            append!(layers, layer(x=xs, y=0*xs + epsilon, Geom.line, Theme(default_color=colorant"orange")))
            append!(layers, layer(x=xs, y=0*xs - epsilon, Geom.line, Theme(default_color=colorant"orange")))
        else
            append!(layers, layer(x=[-delta, delta],y=[epsilon, epsilon],  Geom.line, Theme(default_color=colorant"orange")))
            append!(layers, layer(x=[-delta, delta],y=-[epsilon, epsilon],  Geom.line, Theme(default_color=colorant"orange")))
            append!(layers, layer(x=[-delta, -delta],y=epsilon*[-1,1],   Geom.line, Theme(default_color=colorant"green")))
            append!(layers, layer(x=[ delta,  delta],y=epsilon*[-1,1],   Geom.line, Theme(default_color=colorant"green")))
        end
        plot(layers...)
    end
end

# function make_limit_e_d(n, _)
#     f(x) = x^2
#     n = convert(Int, n)

#     epsilon = (2.0)^(-n)
#     delta = epsilon^2

#     xs = linspace(-2delta, 2delta, 250)
#     ys = map(f, xs)

#     plot(layer(x=xs, y=ys, Geom.line),
#          layer(x = [-delta, -delta, delta, delta, -delta],
#                y = [-epsilon, epsilon, epsilon, -epsilon, -epsilon],
#                Geom.line(preserve_order=true),
#                Theme(default_color=colorant"orange"))
#          )


caption = L"""

Demonstration of $\epsilon$-$\delta$ proof of 
$\lim_{x \rightarrow 0} x^2 = 0$. The orange box is from 
$[-\delta, \delta] \times [-\epsilon, \epsilon]$ where 
$\delta = \epsilon^2$. That the blue line of the
graph does not exit the top of the box, shows
 $|f(x) - L| < \epsilon$
when $0 < |x-c| < \delta$.

"""

# end

film = roll(make_limit_e_d, fps=1, duration=10)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)


caption = L"""

Demonstration of $\epsilon$-$\delta$ proof of $\lim_{x \rightarrow 0}
x^3 = 0$. For any $\epsilon>0$ (the orange lines) there exists a
$\delta>0$ (the red lines of the box) for which the function $f(x)$
does not leave the top or bottom of the box (except possible at the
edges). In this example $\delta^3=\epsilon$.

"""

limit_e_d = gif_to_data(imgfile, caption)


end
