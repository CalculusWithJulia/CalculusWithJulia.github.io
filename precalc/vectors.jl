module vectors
using LaTeXStrings
using WeavePynb

macro q_str(x) 
        "`$x`"
end

fig_size = (400, 300)

using Plots
gr()

x0 = [0, 64]
v0 = [20, 0]
g  = [0, -32]

x(t) = x0 + v0*t + 1/2*g*t^2
v(t) = v0 + g*t
a(t) = g

unit(v::Vector) = v / norm(v)
x_ticks = collect(0:10:80)
y_ticks = collect(0:10:80)


rotate(t, v) = [cos(t) -sin(t); sin(t) cos(t)] * v
function make_arrow!(plt, p0, p; col="blue", width=2px, opacity=1.0, kwargs...)
    quiver!(plt, p0[1:1], p0[2:2], quiver=(p[1:1], p[2:2]), color=col)
    return nothing
end

function make_plot(t)

    xn = (t) -> x0 + v0*t + 1/2*g*t^2
    vn = (t) -> v0 + g*t
    an = (t) -> g

    
    t = 1/10 + t*2/10
    
    ts = linspace(0, 2, 100)
    xys = map(xn, ts)

    xs, ys = [p[1] for p in xys], [p[2] for p in xys]
    
    plt = Plots.plot(xs, ys, legend=false, size=fig_size, xlims=(0,45), ylims=(0,70))
    plot!(plt, zero, extrema(xs)...)
    make_arrow!(plt, xn(t), 10*unit(xn(t)), col="black")
    make_arrow!(plt, xn(t), 10*unit(vn(t)), col="red")
    make_arrow!(plt, xn(t), 10*unit(an(t)), col="green")

    plt
    
   
end

imgfile = tempname() * ".gif"
caption = """

Position, velocity, and acceleration vectors (scaled) for projectile
motion. Vectors are drawn with tail on the projectile. The position
vector (black) points from the origin to the projectile, the velocity
vector (red) is in the direction of the trajectory, and the
acceleration vector (green) is a constant pointing downward.

"""

n = 8
anim = @animate for i=1:n
    make_plot(i)
end
   
gif(anim, imgfile, fps = 1)


xva_trajectory =  WeavePynb.gif_to_data(imgfile, caption)





## a + b

p0 = [0,0]
a1 = [4,1]
b1 = [-2,2]


plt = Plots.plot(legend=false, size=fig_size)
make_arrow!(plt, p0, a1, col="blue")
make_arrow!(plt, p0+a1, b1, col="red")
make_arrow!(plt, p0, a1+b1, col="black")
annotate!(plt, [(2, .25, "a"), (3, 2.25, "b"), (1.25, 1.5, "a+b")])

imgfile = tempname() * ".png"
png(plt, imgfile)
caption = """

The sum of two vectors can be visualized by placing the tail of one at the tip of the other

"""
vector_addition_image =  WeavePynb.gif_to_data(imgfile, caption)



## a - b

p0 = [0,0]
a1 = [4,1]
b1 = [-2,2]

plt = plot(legend=false, size=fig_size)
make_arrow!(plt, p0, a1, col="blue")
make_arrow!(plt, p0, b1, col="red")
make_arrow!(plt, b1, a1-b1, col="black")
annotate!(plt, [(-1, .5, "a"), (2.45, .5, "b"), (1, 1.75, "a-b")])

          
imgfile = tempname() * ".png"
png(plt, imgfile)

caption = """

The sum of two vectors can be visualized by placing the tail of one at the tip of the other

"""

vector_subtraction_image = WeavePynb.gif_to_data(imgfile, caption)

## Generic vector


p0 = [0,0]
a1 = [4,1]
b1 = [-2,2]


plt = plot(legend=false, size=fig_size)
make_arrow!(plt, p0, a1, col="blue")
make_arrow!(plt, [1,1], unit(a1), col="red")
annotate!(plt, [(2, .4, "v"), (1.6, 1.05, "vhat")])

imgfile = tempname() * ".png"
png(plt, imgfile)

caption = """

A vector and its unit vector. They share the same direction, but the unit vector has a standardized magnitude.

"""

generic_vector = WeavePynb.gif_to_data(imgfile, caption)



## Vector decomposition

aa = [1,2]
bb = [2,1]
cc = [4,3]
alpha = 2/3
beta = 5/3

plt = plot(legend=false, size=fig_size)
make_arrow!(plt, p0, cc, col="black", width=1px)
make_arrow!(plt, p0, aa, col="black", width=1px)
make_arrow!(plt, alpha*aa, bb, col="black", width=1px)
make_arrow!(plt, p0, alpha*aa, col="orange", width=4px, opacity=0.5)
make_arrow!(plt, alpha*aa, beta*bb, col="orange", width=4px, opacity=0.5)
annotate!(plt, collect(zip([2, .5, 1.75], [1.25,1.0,2.25], ["c","2/3 * a", "5/3 * b"])))


imgfile = tempname() * ".png"
png(plt, imgfile)

caption = L"""

The vector $\langle 4,3 \rangle$ is written as
$2$/$3$ $\cdot\langle 1,2 \rangle$ $+$ $5$/$3$ $\cdot\langle 2,1 \rangle$. Any vector $\vec{c}$ can be
written uniquely as $\alpha\cdot\vec{a} + \beta \cdot \vec{b}$ provided
$\vec{a}$ and $\vec{b}$ are not parallel.

"""

vector_decomp =  WeavePynb.gif_to_data(imgfile, caption)

plt = plot(legend=false, size=fig_size)
make_arrow!(plt, p0, [2,3], col="black")
make_arrow!(plt, p0, [2,0], col="orange")
make_arrow!(plt, p0+[2,0], [0,3], col="orange")
annotate!(plt, collect(zip([.25, 1,1,1.75], [.35, 1.9,.25,1], ["t","r", "r * cos(t)", "r * sin(t)"]))) #["θ","r", "r ⋅ cos(θ)", "r ⋅ sin(θ)"]

imgfile = tempname() * ".png"
png(plt, imgfile)

caption = L"""

A vector $\langle x, y \rangle$ can be written as $\langle r\cdot
\cos(\theta), r\cdot\sin(\theta) \rangle$ for values $r$ and
$\theta$. The value $r$ is a magnitude, the direction parameterized by
$\theta$.

"""

vector_rtheta = WeavePynb.gif_to_data(imgfile, caption)


end
