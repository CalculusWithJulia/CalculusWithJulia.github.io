module improper_integrals
using WeavePynb, LaTeXStrings

using Gadfly, Reel


function make_sqrt_x_graph(n,_)
    n = convert(Int, n) + 1

    b = 1
    a = 1/2^n
    xs = linspace(1/2^8, b, 250)
    x1s = linspace(a, b)
    f(x) = 1/sqrt(abs(x))
    val, _ = quadgk(f, 1/2^n, b)
    
    plot(layer(x=xs, y=map(f, xs), Geom.line),
         layer(x = [b, a, x1s...], y=[0, 0, map(f, x1s)...], Geom.polygon(fill=true, preserve_order=true),
               Theme(default_color=color("orange"))),
         Guide.title("area under 1/sqrt(x) between 1/$(2^n) and $b is $(rpad(round(val, 2), 4))")
         )
end

film = roll(make_sqrt_x_graph, fps=1, duration=8)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)

caption = L"""

Area under $1/\sqrt{x}$ over $[a,b]$ increases as $a$ gets closer to $0$. Will it grown unbounded or have a limit?

"""

sqrt_graph = gif_to_data(imgfile, caption)


end
