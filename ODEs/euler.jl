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



using Roots
Base.ctranspose(f::Function) = D(f)

function make_brach_graph(n,args...)
    n = max(1, Int(n))
    
    A, B = 1, 1
    f(x) = B/A * x
    g(x) = sqrt(1 - (x-1)^2)
    h(x) = 1 - (2x^2 - 3x + 1)
    
    function i(x)
        U = 1.20600557195676; c = 1.1458340750635
        @assert 0 <= x <= 1
        x1 =  u -> c*u - c/2*sin(2u)
        y1 =  u -> c/2 * (1 - cos(2u))
        
        # solve (x1(u) = x, then return y1(u)
        Roots.fzero(u -> x1(u) - x, 0, U) |> y1
    end
    
    
    J(x, f) = quadgk(u -> sqrt(1 + (f'(u))^2)/sqrt(2*10*f(u)), 0.01, x)[1]
    function ji(t,f)
        out = NaN
        try
            out = Roots.fzero(x -> J(x,f) - t, 0.0001, J(B-.001,f))
        catch err
            out = Roots.fzero(x -> J(x,f) - t, J(B/2,f))
        end
        out
    end
    
    ts = (1:10)/20
    

    fs = [f, g, h, i]
    M = [f => J(B,f) for f in fs]
    cols = [:blue, :green, :red, :brown]
    Cols = [f=>cols[i] for (i,f) in enumerate(fs)]
    
    p = plot(x -> A-fs[1](x), 0, 1, legend=false, color=Cols[fs[1]])
    for fn in fs[2:end]
        plot!(p,x -> A-fn(x), 0.01, .99, color=Cols[fn])
    end
    

    n < 1 && return p
    
    ts = linspace(.05, .55, 8)
    t = ts[n]
    for fn in fs
        if t < M[fn]
            a = ji(t, fn)
            scatter!(p, [a], [A-fn(a)], color=Cols[fn])
        else
            scatter!(p, [B], [A-A], color=Cols[fn])
        end
    end
    
    p
end

film = Reel.roll(make_brach_graph, fps=1, duration=9)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)

caption = """
The race is on. An illustration of beads falling along a path, as can be seen some paths are faster than others. The fastest one follows a cycloid.
"""

brach_graph = gif_to_data(imgfile, caption)



end
