module euler
using WeavePynb, LaTeXStrings
using Reel, Plots, SymPy
gadfly()


function make_euler_graph(n,_)
    x, y = symbols("x, y")
    F(y,x) = y*x
    x0, y0 = 1, 1
    n = convert(Int, n) + 1

    h = (2-1)/5
    xs = zeros(n+1)
    ys = zeros(n+1)
    xs[1] = x0   # index is off by 1
    ys[1] = y0
    for i in 1:n
        xs[i + 1] = xs[i] + h
        ys[i + 1] = ys[i] + h * F(ys[i], xs[i])
    end
    
    p = vectorfieldplot([1, F(y,x)], (x, 1, 2), (y, 0, 1 + 5))
    plot!(p, xs, ys, linewidth=5)
    scatter!(p, xs, ys)
    ## add function
    u = SymFunction("u")
    out = dsolve(u'(x) - F(u(x), x), x, (u, x0, y0))
    plot!(p, rhs(out), x0, xs[end], linewidth=5)

    p
end

film = Reel.roll(make_euler_graph, fps=1, duration=6)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)

caption = """
Illustration of a function stitching together slope field lines to
approximate the answer to an initial-value problem. The function drawn is the
actual solution. 
"""

euler_graph = gif_to_data(imgfile, caption)

end
