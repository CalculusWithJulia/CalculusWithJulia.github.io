module newtons_method


using WeavePynb, LaTeXStrings

using Roots
using Plots
#gr()
pyplot()
fig_size = (600, 400)


function newtons_method_graph(n, f, a, b, c)

    xstars = [c]
    xs = [c]
    ys = [0.0]

    plt = plot(f, a, b, legend=false, size=fig_size)
    plot!(plt, [a, b], [0,0], color=:black)
    

    ts = linspace(a,b)
    for i in 1:n
        x0 = xs[end]
        x1 = x0 - f(x0)/D(f)(x0)
        push!(xstars, x1)
            append!(xs, [x0, x1])
        append!(ys, [f(x0), 0])
    end
    plot!(plt, xs, ys, color=:orange)
    scatter!(plt, xstars, 0*xstars, color=:orange, markersize=5)
    plt
end
caption = """

Illustration of Newton's Method converging to a zero of a function.

"""
n = 6

fn, a, b, c = x->log(x), .15, 2, .2

anim = @animate for i=1:n
    newtons_method_graph(i-1, fn, a, b, c)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

newtons_method_example = gif_to_data(imgfile, caption)


## ------
caption = """

Illustration of Newton's Method converging to a zero of a function,
but slowly as the initial guess, is very poor, and not close to the
zero. The algorithm does converge, but not quickly and not to the nearest root from
the initial guess.

"""

fn, a, b, c = x ->  sin(x) - x/4, -15, 20, 2pi

n = 20
anim = @animate for i=1:n
    newtons_method_graph(i-1, fn, a, b, c)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 2)

newtons_method_poor_x0  = gif_to_data(imgfile, caption)



## --------------

fn, a, b, c, = x -> abs(x)^(0.49),  -2, 2, 1.0
caption = L"""

Illustration of Newton's Method not converging. Here the second
derivative is too big near the zero -- it blows up near $0$ -- and the
convergence does not occur. Rather the iterates increase in their
distance from the zero.

"""

n=10
anim = @animate for i=1:n
    newtons_method_graph(i-1, fn, a, b, c)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 2)

newtons_method_cycle = gif_to_data(imgfile, caption)


## ------------------

caption = L"""

Illustration of Newton's method failing to coverge as for some $x_i$,
$f'(x_i)$ is too close to 0. In this instance after a few steps, the
algorithm just cycles around the local minimum near $0.66$. The values
of $x_i$ repeat in the pattern: $1.0002, 0.7503, -0.0833, 1.0002,
\dots$. This is also an illustration of a poor initial guess. If there
is a local minimum or maximum between the guess and the zero, such
cycles can occur.

"""

fn, a, b, c = x -> x^5 - x + 1, -1.5, 1.4, 0.0

n=7
anim = @animate for i=1:n
    newtons_method_graph(i-1, fn, a, b, c)
end
imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

newtons_method_flat = gif_to_data(imgfile, caption)

## -----------------
caption = L"""

The function $f(x) = x^{20} - 1$ has two bad behaviours for Newton's
method: for $x < 1$ the derivative is nearly $0$ and for $x>1$ the
second derivative is very big. In this illustration, we have an
initial guess of $x_0=8/9$. As the tangent line is fairly flat, the
next approximation is far away, $x_1 = 1.313\dots$. As this guess is
is much bigger than $1$, the ratio $f(x)/f'(x) \approx
x^{20}/(20x^{19}) = x/20$, so $x_i - x_{i-1} \approx (19/20)x_i$
yielding slow, linear convergence until $f''(x_i)$ is moderate. For
this function, starting at $x_0=8/9$ takes 11 steps, at $x_0=7/8$
takes 13 steps, at $x_0=3/4$ takes 55 steps, and at $x_0=1/2$ it takes
$204$ steps.

"""


fn,a,b,c = x -> x^20 - 1,  .7, 1.4, 8/9
n = 10

anim = @animate for i=1:n
    newtons_method_graph(i-1, fn, a, b, c)
end
imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


newtons_method_wilkinson = gif_to_data(imgfile, caption)



end
