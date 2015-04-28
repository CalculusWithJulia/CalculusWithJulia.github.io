module derivatives

using WeavePynb, LaTeXStrings
using Gadfly, Reel, Mustache



## Secant line approaches tangent line...
function secant_line_tangent_line_graph(n, dt)
    f(x) = sin(x)
    c = pi/3
    h = 2.0^(-n) * pi/4
    m = (f(c+h) - f(c))/h
    
    xs = linspace(0, pi)
    plot(layer(x=xs, y=map(f,xs), Geom.line),
         layer(x=xs, y=f(c)+cos(c)*(xs - c), Geom.line, Theme(default_color=color("orange"))),
         layer(x=xs, y=f(c) + m*(xs - c), Geom.line),
         layer(x=[c,c+h],y=[f(c), f(c+h)], Geom.point)
         )
end
caption = L"""

The slope of each secant line represents the *average* rate of change between $c$ and $c+h$. As $h$ goes towards $0$, we recover the slope of the tangent line, which represents the *instantatneous* rate of change.

"""

film = roll(secant_line_tangent_line_graph, fps=1, duration=6)
film.fps=1/2


imgfile = tempname() * ".gif"
write(imgfile, film)
secant_line_tangent_line = gif_to_data(imgfile, caption)


## best approximates the funciton
function line_approx_fn_graph(n,_)
    f(x) = sin(x)
    c = pi/3
    h = round(2.0^(-n) * pi/2,2)
    m = cos(c)
    Gadfly.plot([f, x -> f(c) + m*(x-c)], c-h, c+h, Guide.xticks(ticks=[c-h, c, c+h]))
end
caption = L"""

The tangent line is the best linear approximation to the function at the point $(c, f(c))$.

"""

film = roll(line_approx_fn_graph, fps=1, duration=6)
film.fps=1/2


imgfile = tempname() * ".gif"
write(imgfile, film)
line_approx_fn = gif_to_data(imgfile, caption)


end
