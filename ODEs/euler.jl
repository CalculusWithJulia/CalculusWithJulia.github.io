module euler
using WeavePynb, LaTeXStrings
using SymPy
using QuadGK

using Plots
gr()
fig_size = (600, 400)

function slopefield_plot(fyx; xlim=(-5, 5), ylim=(-5, 5), n=8)
    xs = repeat(collect(linspace(xlim[1], xlim[2], n)), inner=(n,))
    ys = repeat(collect(linspace(ylim[1], ylim[2], n)), outer=(n,))

    us, vs = broadcast((x,y)->1, xs, ys), broadcast(fyx, ys, xs)
    m = maximum(sqrt.(1 .+ vs.^2))
    lambda = max(xlim[2]-xlim[1], ylim[2]-ylim[1]) / n / m

    quiver(xs, ys, quiver=(lambda*us, lambda*vs), legend=false)
end
function vfieldplot(fx, fy; xlim=(-5,5), ylim=(-5,5), n=7)
    xs = linspace(xlim..., n)
    ys = linspace(ylim..., n)

    us = vec([x for x in xs, y in ys])
    vs = vec([y for x in xs, y in ys])
    fxs = vec([fx(x,y) for x in xs, y in ys])
    fys = vec([fy(x,y) for x in xs, y in ys])

    m = maximum((fxs.^2 .+ fys.^2).^(1/2))
    lambda =  max(xlim[2]-xlim[1], ylim[2]-ylim[1]) / n / m

    
    quiver(us, vs, quiver=(lambda*fxs, lambda*fys), legend=false)
end

function make_euler_graph(n)
    x, y = symbols("x, y")
    F(y,x) = y*x
    x0, y0 = 1, 1

    h = (2-1)/5
    xs = zeros(n+1)
    ys = zeros(n+1)
    xs[1] = x0   # index is off by 1
    ys[1] = y0
    for i in 1:n
        xs[i + 1] = xs[i] + h
        ys[i + 1] = ys[i] + h * F(ys[i], xs[i])
    end

    p = vfieldplot((x,y) -> 1, F, xlim=(1,2), ylim = (0, 6))
    plot!(p, xs, ys, linewidth=5)
    scatter!(p, xs, ys)
    ## add function
    u = SymFunction("u")
    out = dsolve(u'(x) - F(u(x), x), x, (u, x0, y0))
    plot!(p, rhs(out), x0, xs[end], linewidth=5)

    p
end




n = 5
anim = @animate for i=1:n
    make_euler_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


caption = """
Illustration of a function stitching together slope field lines to
approximate the answer to an initial-value problem. The function drawn is the
actual solution. 
"""

euler_graph = gif_to_data(imgfile, caption)



using Roots
using QuadGK
Base.ctranspose(f::Function) = D(f)


function make_brach_graph_old(n)
    
    A, B = 1, 1
    f(x) = B/A * x
    g(x) = sqrt(1 - (x-1)^2)
    h(x) = 1 - (2x^2 - 3x + 1)
    
    i = x -> begin
        U = 1.20600557195676; c = 1.1458340750635
        if x <= 0 || x >= 1
            return NaN
        end
        x1 =  u -> c*u - c/2*sin(2u)
        y1 =  u -> c/2 * (1 - cos(2u))
        
        # solve (x1(u) = x, then return y1(u)
        Roots.fzero(u -> x1(u) - x, 0, U) |> y1
    end
    
    
    J(x, f) = QuadGK.quadgk(u -> sqrt(1 + (f'(u))^2)/sqrt(2*10*f(u)), 0.01, x)[1]
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
    Cols = Dict(f=>cols[i] for (i,f) in enumerate(fs))
    
    p = plot(x -> A-fs[1](x), 0, 1, legend=false, color=cols[1], xlim=(0,1), ylim=(-0.25, 1))
    for (i,fn) in zip(2:4, fs[2:end])
        plot!(p,x -> A-fn(x), 0.0001, .99, color=cols[i])
    end

    n == 0 && scatter!(p, [0], [1], color=:black)
    n < 1 && return p
    
    ts = linspace(.05, .55, 9)
    t = ts[n]
    for (i,fn) in enumerate(fs)
        if t < J(B,f)
            a = ji(t, fn)
            scatter!(p, [a], [A-fn(a)], color=cols[i])
        else
            scatter!(p, [B], [A-A], color=cols[i])
        end
    end
    
    p
end



#https://pdfs.semanticscholar.org/66c1/4d8da6f2f5f2b93faf4deb77aafc7febb43a.pdf
using Roots
Base.ctranspose(f::Function) = x -> D(f)(x)

function brach(f, x0, vx0, y0, vy0, dt, n)
    m = 1
    g = 9.8

    axs = Float64[0]
    ays = Float64[-g]
    vxs = Float64[vx0]
    vys = Float64[vy0]
    xs = Float64[x0]
    ys = Float64[y0]

    for i in 1:n
        x = xs[end]
        vx = vxs[end]

        ax = -f'(x) * (f''(x) * vx^2 + g) / (1 + f'(x)^2)
        ay = f''(x) * vx^2 + f'(x) * ax

        push!(axs, ax)
        push!(ays, ay)

        push!(vxs, vx + ax * dt)
        push!(vys, vys[end] + ay * dt)
        push!(xs, x       + vxs[end] * dt)# + (1/2) * ax * dt^2)
        push!(ys, ys[end] + vys[end] * dt)# + (1/2) * ay * dt^2)
    end

    [xs ys vxs vys axs ays]

end


fs = [x -> 1 - x,
      x -> (x-1)^2,
      x -> 1 - sqrt(1 - (x-1)^2),
      x ->  - (x-1)*(x+1),
      x -> 3*(x-1)*(x-1/3)
      ]


MS = [brach(f, 1/100, 0, 1, 0, 1/100, 100) for f in fs]

    
function make_brach_graph(n)

    p = plot(xlim=(0,1), ylim=(-1/3, 1), legend=false)
    for (i,f) in enumerate(fs)
        plot!(f, 0, 1)
        U = MS[i]
        x = min(1.0, U[n,1])
        scatter!(p, [x], [f(x)])
    end
    p
    
end



n = 4
anim = @animate for i=[1,5,10,15,20,25,30,35,40,45,50,55,60]
    make_brach_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


caption = """
The race is on. An illustration of beads falling along a path, as can be seen, some paths are faster than others. The fastest path would follow a cycloid. See [Bensky and Moelter](https://pdfs.semanticscholar.org/66c1/4d8da6f2f5f2b93faf4deb77aafc7febb43a.pdf) for details on simulating a bead on a wire.
"""

brach_graph = gif_to_data(imgfile, caption)


imgfile = "figures/galileo.gif"
caption = """
As early as 1638, Galileo showed that an object falling along `AC` and then `CB` will fall faster than one traveling along `AB`, where `C` is on the arc of a circle.
From the [History of Math Archive](http://www-history.mcs.st-and.ac.uk/HistTopics/Brachistochrone.html).
"""

galileo_picture = gif_to_data(imgfile, caption)



end
