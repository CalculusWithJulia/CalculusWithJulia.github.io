




# to use Plots or PyPlot

using Plots; plotly()
using ForwardDiff
D(r, n=1) = n > 1 ? D(D(r),n-1) : t -> ForwardDiff.derivative(r, float(t))
Base.adjoint(r::Function) = D(r)


## Turn a vector of vectors into xs, ys, and optionally zs
xs_ys(vs) = (A=hcat(vs...);[A[i,:] for i in eachindex(vs[1])])
xs_ys(v,vs...) = xs_ys([v, vs...])
xs_ys(r::Function, a, b, n=100) = xs_ys(r.(range(a, stop=b, length=n)))

function arrow!(p, v; kwargs...)

    d = length(p)
            if d == 2
                quiver!(xs_ys([p])..., quiver=Tuple(xs_ys([v])); kwargs...)
            elseif d == 3
                # 3d quiver needs support
                # https://github.com/JuliaPlots/Plots.jl/issues/319#issue-159652535
                # headless arrow instead
                plot!(xs_ys(p, p+v)...; kwargs...)
            end
        end



r2(t) = [sin(t), cos(t)]
r(t) = [sin(t), cos(t), sin(2t)]



    # 2d parameterized curver
ts = range(0, 2pi, length=100)

    # harder way
    xys = r2.(ts)
    xs = [u[1] for u in xys]
    ys = [u[2] for u in xys]
    plot(xs, ys)

    # easier
    plot(xs_ys(r2, ts)...)




# 3D parameterized curver
    ts = range(0, 2pi, length=100)

    ## harder
    xyzs = r.(ts)
    xs = [u[1] for u in xyzs]
    ys = [u[2] for u in xyzs]
    zs = [u[3] for u in xyzs]
    plot(xs, ys, zs)


    plot(xs_ys(r, ts)...)

    # 2D add an arrow to curve (p,v)
    p, v = r2(1), r2'(1)
    plot(xs_ys(r2, ts)...)

    ## interface wants quiver([xs], [ys], quiver=(us, vs))
    asv(v) = Tuple(v[i:i] for i in eachindex(v))
    quiver!(asv(p)..., quiver=asv(v))  # lack of symmetry

    ## helper function works in 2, 3 d
        function arrow!(p, v; kwargs...)
            d = length(p)
            if d == 2
                quiver!(asv(p)..., quiver=asv(v); kwargs...)
            elseif d == 3
                # 3d quiver needs support
                # https://github.com/JuliaPlots/Plots.jl/issues/319#issue-159652535
                # headless arrow instead
                plot!(xs_ys(p, p+v)...; kwargs...)
            end
        end
# 3D add an arrow to curve (p,v)
            plot(xs_ys(r, ,ts)..., legend=false)
            arrow!(r(1), r'(1))

            # plot a contour

            xs = ts
            ys = ts
            f(x,y) = x^2 - sin(x*y)
            contour(xs, ys, f)
            # plot a surface
            surface(xs, ys, f)

            # surface + contour
            ## XXX not so well developed
        # change perpspective
        camera=(30,40)
# add gradient arrow
# parameterized surfaces





## PyPlot
# 2d parameterized curver
# 3D parameterized curver
# 2D add an arrow to curve (p,v)
# 3D add an arrow to curve (p,v)
# plot a contour
# plot a surface
# surface + contour
# change perpspective
# add gradient arrow
# parameterized surfaces
