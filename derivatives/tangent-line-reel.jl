## Make a movie of the tangent line
using Gadfly
using Reel

## Can make this better!

function make_tangent_reel(f, x0, h, xlim, ylim, fname="output.gif", n=10)

    a,b = xlim

    xs = linspace(a, b, 1000)
    ys = map(f, xs)
    
    x = Float64[]; y = Float64[]
    hs = [linspace(h, 1e-12, n-1), 1e-12]
    function render(n, dn)
        h = hs[n+1]
        m = (f(x0 + h) - f(x0))/h
        tls = map(x -> f(x0) + m * (x - x0), xs)
        tls[(tls .< ylim[1]) | (tls .> ylim[2])] = NaN
        Gadfly.plot(
                    layer(x = xs, y = ys, Geom.line, Theme(default_color=colorant"red"))
                    ,layer(x = xs, y=tls, Geom.line, Theme(default_color=colorant"blue"))
                    ,layer(x = [x0, x0+h], y=[f(x0), f(x0+h)], Geom.point)
                    )
    end

    film = roll(render, fps=1, duration=n)
    write(fname, film, fps=1) #
    
end

make_tangent_reel(sin, pi/4, pi/2, [0, pi], [0, 1.5], "output.gif")

