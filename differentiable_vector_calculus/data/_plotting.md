# 2D and 3D plots in Julia with Plots

This covers plotting the typical 2D and 3D plots in Julia with the `Plots` package.


```
using Plots
using LinearAlgebra, ForwardDiff
import PyPlot
import Contour: contours, levels, level, lines, coordinates
```

We will make use of some helper functions that will simplify plotting. These will be described in more detail in the following:

```
xs_ys(vs) = Tuple(eltype(vs[1])[vs[i][j] for i in 1:length(vs)] for j in eachindex(first(vs)))
xs_ys(v,vs...) = xs_ys([v, vs...])
xs_ys(r::Function, a, b, n=100) = xs_ys(r.(range(a, stop=b, length=n)))

function arrow!(p, v; kwargs...)
  if length(p) == 2
     quiver!(xs_ys([p])..., quiver=Tuple(xs_ys([v])); kwargs...)
  elseif length(p) == 3
    # 3d quiver needs support
    # https://github.com/JuliaPlots/Plots.jl/issues/319#issue-159652535
    # headless arrow instead
    plot!(xs_ys(p, p+v)...; kwargs...)
	end
end
```

We will also use the `ForwardDiff` for derivatives and use the "prime" notation:

```
using ForwardDiff
function D(f, n::Int=1)
    n < 0 && throw(ArgumentError("n is a non-negative integer"))
    n == 0 && return f
    n == 1 && return t -> ForwardDiff.derivative(f, float(t))
    D(D(f), n-1)
end
Base.adjoint(r::Function) = D(r)
```

We will need to manipulate contours directly, so pull in the `Contours` package, using `import` to avoid name collisions and explicitly listing the methods we will use:

```
import Contour: contours, levels, lines, coordinates
```

Finally, we need some features for vectors:

```
using LinearAlgebra
```

## Parametrically described curves in space

Let $r(t)$ be a vector-valued function with values in $R^d$, $d$ being $2$ or $3$. A familiar example is the equation for a line that travels in the direction of $\vec{v}$ and goes through the point $P$: $r(t) = P + t \cdot \vec{v}$.
A *parametric plot* over $[a,b]$ is the collection of all points $r(t)$ for $a \leq t \leq b$.


In `Plots`, parameterized curves can be plotted through two interfaces, here illustrated for $d=2$: `plot(f1, f2, a, b)` or `plot(xs, ys)`. The former is convenient for some cases, but typically we will have a function `r(t)` which is vector-valued, as opposed to a vector of functions. As such, we only discuss the latter.

An example helps illustrate. Suppose $r(t) = \langle \sin(t), 2\cos(t) \rangle$ and the goal is to plot the full ellipse by plotting over $0 \leq t \leq 2\pi$. As with plotting of curves, the goal would be to take many points between `a` and `b` and from there generate the $x$ values and $y$ values.

Let's see this with 5 points, the first and last being identical due to the curve:

```
r(t) = [sin(t), 2cos(t)]
ts = range(0, stop=2pi, length=5)
```

Then we can create the $5$ points easily through broadcasting:

```
vs = r.(ts)
```

This returns a vector of points (stored as vectors). The plotting function wants two collections: the set of $x$ values for the points and the set of $y$ values. The data needs to be generated differently or reshaped. The function `xs_ys` above takes data in this style and returns the desired format, returning a tuple with the $x$ values and $y$ values pulled out:

```
xs_ys(vs)
```

To plot this, we "splat" the tuple so that `plot` gets the arguments separately:

```
plot(xs_ys(vs)...)
```

This  basic plot is lacking, of course, as there are not enough points. Using more initially is a remedy. Rather than generate the `ts` separately, `xs_ys` has a simple frontend `xs_ys(r, a, b)` which does this work itself:

```
plot(xs_ys(r, 0, 2pi, 100)...)
```


### Plotting a space curve in 3 dimensions

A parametrically described curve in 3D is similarly created. For example, a helix is described mathematically by $r(t) = \langle sin(t), cos(t), t \rangle$. Here we graph two turns:

```
r(t) = [sin(t), cos(t), t]
plot(xs_ys(r, 0, 4pi)...)
```

### Adding a vector

The tangent vector indicates the instantaneous direction one would travel were they walking along the space curve. We can add a tangent vector to the graph. The `quiver!` function would be used to add a 2D vector, but `Plots` does not currently have a `3D` analog. In addition, `quiver!` has a somewhat cumbersome calling pattern when adding just one vector. So we have the `arrow!` function defined above that uses `quiver` for 2D arrows and a simple line for 3D arrows. As a vector incorporates magnitude and direction, but not a position, `arrow!` needs both a point for the position and a vector.

Here is how we can visualize the tangent vector at a few points on the helix:

```
plot(xs_ys(r, 0, 4pi)..., legend=false)
ts = range(0, 4pi, length=5)
for t in ts
   arrow!(r(t), r'(t))
end
```


```
note("""Adding many arrows this way would be inefficient.""")
```

### Setting a viewing angle for 3D plots

For 3D plots, the viewing angle can make the difference in visualizing the key features. In `Plots`, some backends allow the viewing angle to be set with the mouse by clicking and dragging. Not all do. For such, the `camera` argument is used, as in `camera(azimuthal, elevation)` where the angles are given in degrees. If the $x$-$y$-$z$ coorinates are given, then `elevation` or *inclination*, is the angle between the $z$ axis and the $x-y$ plane (so `90` is a top view) and `azimuthal` is the angle in the $x-y$ plane from the $x$ axes.


## Visualizing functions from $R^2 \rightarrow R$

If a function $f: R^2 \rightarrow R$ then a graph of $(x,y,f(x,y))$ can be represented in 3D. It will form a surface. Such graphs can be most simply made by specifying a set of $x$ values, a set of $y$ values and a function $f$, as with:

```
xs = range(-2, stop=2, length=100)
ys = range(-pi, stop=pi, length=100)
f(x,y) = x*sin(y)
surface(xs, ys, f)
```

Rather than pass in a function, values can be passed in. Here they are generated with a list comprehension. The `y` values are innermost to match the graphic when passing in a function object:

```
zs = [f(x,y) for y in ys, x in xs]
surface(xs, ys, zs)
```

Remembering if the `ys` or `xs` go first in the above can be
hard. Alternatively, broadcasting can be used. The command `f.(xs,ys)`
would return a vector, as the `xs` and `ys` match in shape--they are both column vectors. But the
*transpose* of `xs` looks like a *row* vector and `ys` looks like a
column vector, so broadcasting will create a matrix of values, as
desired here:

```
surface(xs, ys, f.(xs', ys))
```


This graph shows the tessalation algorithm. Here only the grid in the $x$-$y$ plane is just one cell:

```
xs = [-1,1]; ys = [-1,1]
f(x,y) = x*y
surface(xs, ys, f.(xs', ys))
```

A more accurate graph, can be seen here:

```
xs = ys = range(-2,2, length=100)
surface(xs, ys, f)
```


### Contour plots

Returning to the



The contour plot of $f:R^2 \rightarrow R$ draws level curves, $f(x,y)=c$, for different values of $c$ in the $x-y$ plane.
They are produced in a similar manner as the surface plots:

```
contour(xs, ys, f)
```

The cross in the middle corresponds to $c=0$, as when $x=0$ or $y=0$ then $f(x,y)=0$.

Similarly, computed values for $f(x,y)$ can be passed in. Here we change the function:

```
f(x,y) = 2 - (x^2 + y^2)
zs = [f(x,y) for y in ys, x in xs]
contour(xs, ys, zs)
```

The chosen levels can be specified by the user through the `levels` argument, as in:

```
gr()
contour(xs, ys, zs, levels = [-1.0, 0.0, 1.0])
```

If only a single level is desired, as scalar value can be specified. For example, this next graphic shows the $0$-level of the [devil]](http://www-groups.dcs.st-and.ac.uk/~history/Curves/Devils.html)'s curve.

```
gr()
a, b = -1, 2
f(x,y) = y^4 - x^4 + a*y^2 + b*x^2
xs = ys = range(-5, stop=5, length=100)
contour(xs, ys, f, levels=[0.0])
```


Contour plots are well known from the presence of contour lines on many maps. Contour lines indicate constant elevations. A peak is characterized by a series of nested closed paths. The following graph shows this for the peak at $(x,y)=(0,0)$.

```
#plotly()
xs = ys = range(-pi/2, stop=pi/2, length=100)
f(x,y) = sinc(sqrt(x^2 + y^2))   # sinc(x) is sin(x)/x
contour(xs, ys, f)
```

Contour plots can be filled with colors through the `contourf` function:

```
contourf(xs, ys, zs)
```


### Combining surface plots and contour plots


In `PyPlot` it is possible to add a contour lines to the surface, or projected onto an axis. Here is an example:

```
import PyPlot
xs = ys = range(-2, stop=2, length=100)
f(x,y) = 2 + x^2 + y^2
zs = [f(x,y) for y in ys, x in xs]
PyPlot.plot_surface(xs, ys, zs)
PyPlot.contour3D(xs, ys, zs)
ax = PyPlot.gca()
ax.contour(xs, ys, zs, offset=0)
```

To replicate something similar, though not as satisfying, in `Plots` we use the `Contour` package.

```
import Contour
xs = ys = range(-2, stop=2, length=100)
f(x,y) = 2 + x^2 + y^2
zs = [f(x,y) for y in ys, x in xs]
p = surface(xs, ys, zs, legend=false, fillalpha=0.5)

## we add to the graphic p, then plot
for cl in levels(contours(xs, ys, zs))
    lvl = level(cl) # the z-value of this contour level
    for line in lines(cl)
        _xs, _ys = coordinates(line) # coordinates of this line segment
        _zs = 0 * _xs
        plot!(p, _xs, _ys, lvl .+ _zs, alpha=0.5) # add on surface
        plot!(p, _xs, _ys, _zs, alpha=0.5)        # add on x-y plane
    end
end
p
```

There is no hidden line calculuation, in place we give the contour lines a transparency through the argument `alpha=0.5`.


### Gradient and surface plots

The surface plot of $f: R^2 \rightarrow R$ plots $(x, y, f(x,y))$ as a surface. The *gradient* of $f$ is $\langle \partial f/\partial x, \partial f/\partial y\rangle$. It is a two-dimensional object indicating the direction at a point $(x,y)$ where the surface has the greatest ascent. Illurating the gradient and the surface on the same plot requires embedding the 2D gradient into the 3D surface. This can be done by adding a constant $z$ value to the gradient, such as $0$.

```
f(x,y) = 2 - (x^2 + y^2)
xs = ys = range(-2, stop=2, length=100)
zs = [f(x,y) for y in ys, x in xs]

surface(xs, ys, zs, camera=(40, 25), legend=false)
p = [-1, 1] # in the region graphed, [-2,2] × [-2, 2]

f(x) = f(x...)
v = ForwardDiff.gradient(f, p)


# add 0 to p and v (two styles)
push!(p, -15)
scatter!(xs_ys([p])..., markersize=3)

v = vcat(v, 0)
arrow!(p, v)
```


### The tangent plane

Let $z = f(x,y)$ describe a surface, and $F(x,y,z) = f(x,y) - z$. The the gradient of $F$ at a point $p$ on the surface, $\nabla F(p)$, will be normal to the surface and for a function, $f(p) + \nabla f \cdot (x-p)$ describes the tangent plane. We can visualize each, as follows:

```
f(x,y) = 2 - x^2 - y^2
F(x,y,z) = z - f(x,y)
F(x) = F(x...)
p = [1/10, -1/10]
p1 = vcat(p, f(p...)) # note F(p1) == 0
n = ForwardDiff.gradient(F, p1)
tl(x) = f(p) +  ForwardDiff.gradient(f, p) ⋅ (x - p)
tl(x,y) = tl([x,y])

xs = ys = range(-2, stop=2, length=100)
surface(xs, ys, f)
surface!(xs, ys, tl)
arrow!(p1, 5n)
```

From some viewing angles, the normal does not look perpendicular to the tangent plane. This is a quick verification for a randomly chosen point in the $x-y$ plane:

```
a, b = randn(2)
dot(n, (p1-[a,b,tl(a,b)]))
```




### Parameterized surface plots

As illustrated, we can plot surfaces of the form $(x,y,f(x,y)$. However, not all surfaces are so readily described. For example, if $F(x,y,z)$ is a function from $R^3 \rightarrow R$, then $F(x,y,z)=c$ is a surface of interest. For example, the sphere of radius one is a solution to $F(x,y,z)=1$ where $F(x,y,z) =  x^2 + y^2 + z^2$.

Plotting such generally described surfaces is not so easy, but *parameterized* surfaces can be represented. For example, the sphere as a surface is not represented as a surface of a function, but can be represented in spherical coordinates as parameterized by two angles, essentially an "azimuth" and and "elevation", as used with the `camera` argument.

Here we define functions that represent $(x,y,z)$ coordinates in terms of the corresponding spherical coordinates $(r, \theta, \phi)$.

```
# spherical: (radius r, inclination θ, azimuth φ)
X(r,theta,phi) = r * sin(theta) * sin(phi)
Y(r,theta,phi) = r * sin(theta) * cos(phi)
Z(r,theta,phi) = r * cos(theta)
```

We can parameterize the sphere by plotting values for $x$, $y$, and $z$ produced by a sequence of values for $\theta$ and $\phi$, holding $r=1$:

```
pyplot()
thetas = range(0, stop=pi,   length=50)
phis   = range(0, stop=pi/2, length=50)

xs = [X(1, theta, phi) for theta in thetas, phi in phis]
ys = [Y(1, theta, phi) for theta in thetas, phi in phis]
zs = [Z(1, theta, phi) for theta in thetas, phi in phis]

surface(xs, ys, zs)
```

```
note("The above may not work with all backends for `Plots`, even if those that support 3D graphics.")
```

### Plotting  F(x,y, z) = c

There is no built in functionality in `Plots` to create surface described by $F(x,y,z) = c$. An example of how to provide some such functionality for `PyPlot` appears [here](https://stackoverflow.com/questions/4680525/plotting-implicit-equations-in-3d ). The following implements the same approach for `Plots`.


```
gr()
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
            cnt = contours(Y1,Z1,X1, [c])
            for line in lines(levels(cnt)[1])
                ys, zs = coordinates(line) # coordinates of this line segment
                plot!(p, x .+ 0 * ys, ys, zs, color=slices[:x])
          end
        end
    end

    if :y ∈ keys(slices)
        for y in _linspace(yrng, nlevels)
            local Y1 = [F(x,y,z) for x in X1, z in Z1]
            cnt = contours(Z1,X1,Y1, [c])
            for line in lines(levels(cnt)[1])
                xs, zs = coordinates(line) # coordinates of this line segment
                plot!(p, xs, y .+ 0 * xs, zs, color=slices[:y])
            end
        end
    end

    if :z ∈ keys(slices)
        for z in _linspace(zrng, nlevels)
            local Z1 = [F(x, y, z) for x in X1, y in Y1]
            cnt = contours(X1, Y1, Z1, [c])
            for line in lines(levels(cnt)[1])
                xs, ys = coordinates(line) # coordinates of this line segment
                plot!(p, xs, ys, z .+ 0 * xs, color=slices[:z])
            end
        end
    end


    p
end
```

To use it, we see what happens when a sphere if rendered:

```
f(x,y,z) = x^2 + y^2 + z^2 - 25
plot_implicit(f)
```

The graphic is a bit hard to read. Showing only 1 set of slices with more levels can lead to an improvement:

```
plot_implicit(f, nlevels=20, slices=Dict(:z=>:blue))
```

This figure comes from a February 14, 2019 article in the [New York Times](https://www.nytimes.com/2019/02/14/science/math-algorithm-valentine.html). It shows an equation for a "heart," as the graphic will illustrate:

```
a,b = 1,3
f(x,y,z) = (x^2+((1+b)*y)^2+z^2-1)^3-x^2*z^3-a*y^2*z^3
plot_implicit(f, xrng=(-2,2),yrng=(-1,1),zrng=(-1,2),
   nlevels=40, slices=Dict(:z=>:blue))
```

## Vector fields

Consider a function $f: R^2 \rightarrow R$. The gradient function, $\nabla f$ is a function from $R^2$ into $R^2$. Such functions can be visualized in terms of a vector field. For each point, $p$, the  gradient (or a scaled version) is indicated by anchoring it at $p$. This is typically done for a grid of values. In the code below, we scale the size of each vector so that they stay within the grid.


```
using LinearAlgebra

f(x,y) = x^2 - y^2
f(x) = f(x...)
xs = ys = range(-2, stop=2, length=10)

ps = [[x,y] for x in xs, y in ys]
vs = [ForwardDiff.gradient(f, p) for p in ps]

# scale the vs
m = maximum(norm.(vs))
vs = 4/10/m * vs

quiver(xs_ys(ps)..., quiver=xs_ys(vs))
```

We see the use of `quiver` to add vectors in 2D. The `ps` need to be specified as `xs, ys`, hence the splatting, whereas the `quiver` *argument* expects a tuple of vectors, hence no splatting. Calling `quiver` this way, as opposed to adding individual lines through `arrow`, say, is much more efficient.

The scale used is simply computed. The points are spaced evenly with $4/10$ units between them.  The longest vector will have this length, so will not be able to leave the cell, hence the vectors won't overlap, as would happen with this example otherwise.

One last comment, in place of the comprehension to form the `vs`, broadcasting, as with `vs = ForwardDiff.gradient.(f, ps)`, could be used.
