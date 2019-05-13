## plot F(x,y,z) = c over xrng, yrng, zrng by plotting contours slices

function plot_implicit(F, c=0;
                       xrng=(-5,5), yrng=xrng, zrng=xrng,
                       nlevels=6,         # number of levels in a direction
                       slices=Dict(:x => :blue,
                                   :y => :red,
                                   :z => :green), # which directions and color
                       kwargs...          # passed to initial `plot` call
                       )

    _linspace(rng, n=150) = range(rng[1], stop=rng[2], length=n)

    X1, Y1, Z1 = _linspace(xrng), _linspace(yrng), _linspace(zrng)

    p = Plots.plot(;legend=false,kwargs...)

    if :x ∈ keys(slices)
        for x in _linspace(xrng, nlevels)
            local X1 = [F(x,y,z) for y in Y1, z in Z1]
            cnt = Contour.contours(Y1,Z1,X1, [c])
            for line in lines(levels(cnt)[1])
                ys, zs = coordinates(line) # coordinates of this line segment
                plot!(p, x .+ 0 * ys, ys, zs, color=slices[:x])
          end
        end
    end

    if :y ∈ keys(slices)
        for y in _linspace(yrng, nlevels)
            local Y1 = [F(x,y,z) for x in X1, z in Z1]
            cnt = Contour.contours(Z1,X1,Y1, [c])
            for line in lines(levels(cnt)[1])
                xs, zs = coordinates(line) # coordinates of this line segment
                plot!(p, xs, y .+ 0 * xs, zs, color=slices[:y])
            end
        end
    end

    if :z ∈ keys(slices)
        for z in _linspace(zrng, nlevels)
            local Z1 = [F(x, y, z) for x in X1, y in Y1]
            cnt = Contour.contours(X1, Y1, Z1, [c])
            for line in lines(levels(cnt)[1])
                xs, ys = coordinates(line) # coordinates of this line segment
                plot!(p, xs, ys, z .+ 0 * xs, color=slices[:z])
            end
        end
    end


    p
end
