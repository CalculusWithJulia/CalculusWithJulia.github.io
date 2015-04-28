module area

using Gadfly, Reel
using WeavePynb, LaTeXStrings

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
        append!(layers, layer(x=[1,0,0,1, 0], y=[1,1,0,1,1], Geom.line(preserve_order=true), Theme(default_color=color(colors[1]))))
    else    
        for k in (n-1):n
        
            xs = linspace(0,1,1+2^(k-1))
            ys = map(f, xs)
            append!(layers, layer(x=xs, y=ys, Geom.line, Theme(default_color=color(colors[k]))))
        end
    end
    plot(layers...)
end

film = roll(make_triangle_graph, fps=1, duration=6)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)

caption = """

Illustration of Archimedes' method of exhaustion to compute the area within a parabolic figure.

"""

archimedes_parabola = gif_to_data(imgfile, caption)

### Riemann sum picture

## A better picture waits for newer Gadfly with polygon support...


end
