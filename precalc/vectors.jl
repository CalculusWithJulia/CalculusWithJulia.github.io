module vectors
using LaTeXStrings

macro q_str(x) 
        "`$x`"
end


gif_to_data_tpl = """

<div class="well">
<figure>
    <img src="data:image/gif;base64, {{{:data}}}"/>
  <figcaption>{{:caption}}</figcaption>
</figure>
</div>

"""


using Mustache, Gadfly, DataFrames, Reel

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
function make_arrow(p0, p; col="blue", width=2px, opacity=1.0, kwargs...)
    θ, λ = pi/16, 1/20
    
    l =  rotate(pi - θ, p) * λ
    r =  rotate(pi + θ, p) * λ

    pos = [p0 p0+p p0+p+l p0+p+r p0+p]
    layer(x=pos[1,:]', y=pos[2,:]',
          Geom.line(preserve_order=true),
          Theme(default_color=color(col), line_width=width, lowlight_opacity=opacity),
          kwargs...
          )
end

function make_plot(t,_)
    t = 1/10 + t*2/10
    
    ts = linspace(0, 2, 100)
    xys = map(x, ts)

    layers=Any[]
    push!(layers, layer(x=[p[1] for p in xys], y=[p[2] for p in xys], Geom.line))
    push!(layers, layer(x=0:80, y=0*collect(0:80), Geom.line,
                        Theme(default_color=color("orange"), lowlight_opacity=0.5)))
    push!(layers, make_arrow(x(t), 10*unit(x(t)), col="black"))
    push!(layers, make_arrow(x(t), 10*unit(v(t)), col="red"))
    push!(layers, make_arrow(x(t), 10*unit(a(t)), col="green"))

    plot(layers...,  Guide.xticks(ticks=x_ticks), Guide.yticks(ticks=y_ticks))
end
    

film = roll(make_plot, fps=1, duration=11)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)
data = readall(`julia4 -e "base64encode(readall(\"$imgfile\")) |> print"`);
caption = """

Position, velocity, and acceleration vectors (scaled) for projectile
motion. Vectors are drawn with tail on the projectile. The position
vector (black) points from the origin to the projectile, the velocity
vector (red) is in the direction of the trajectory, and the
acceleration vector (green) is a constant pointing downward.

"""
xva_trajectory =  Mustache.render(gif_to_data_tpl, data=data, caption=caption)




## a + b

p0 = [0,0]
a1 = [4,1]
b1 = [-2,2]


vector_addition_image = plot(make_arrow(p0, a1, col="blue"),
                             make_arrow(p0+a1, b1, col="red"),
                             make_arrow(p0, a1+b1, col="black"),
                             layer(x=[2, 3, 1.25], y=[.5,2.25,1.75], label=["a","b", "a+b"], Geom.label)
                             )

imgfile = tempname() * ".png"
io = open(imgfile, "w")
writemime(io, "image/png", vector_addition_image)
close(io)

data = readall(`julia4 -e "base64encode(readall(\"$imgfile\")) |> print"`);
caption = """

The sum of two vectors can be visualized by placing the tail of one at the tip of the other

"""
vector_addition_image =  Mustache.render(gif_to_data_tpl, data=data, caption=caption)



## a - b

p0 = [0,0]
a1 = [4,1]
b1 = [-2,2]


vector_subtraction_image = plot(make_arrow(p0, a1, col="blue"),
                             make_arrow(p0, b1, col="red"),
                             make_arrow(b1, a1-b1, col="black"),
                             layer(x=[2, -1, 1.25], y=[.5,.75,1.75], label=["a","b", "a-b"], Geom.label)
                             )

imgfile = tempname() * ".png"
io = open(imgfile, "w")
writemime(io, "image/png", vector_subtraction_image)
close(io)

data = readall(`julia4 -e "base64encode(readall(\"$imgfile\")) |> print"`);
caption = """

The sum of two vectors can be visualized by placing the tail of one at the tip of the other

"""
vector_subtraction_image =  Mustache.render(gif_to_data_tpl, data=data, caption=caption)


## Generic vector


p0 = [0,0]
a1 = [4,1]
b1 = [-2,2]


generic_vector = plot(make_arrow(p0, a1, col="blue"),
                      make_arrow([1,1], unit(a1), col="red"),
                      layer(x=[.25,3.5], y=[.1, .9], label=["(x₀, y₀)","(x₁, y₁)"], Geom.label),
                      Guide.xticks(ticks=collect(0:4)), Guide.yticks(ticks=collect(0:4))
                      )

imgfile = tempname() * ".png"
io = open(imgfile, "w")
writemime(io, "image/png", generic_vector)
close(io)

data = readall(`julia4 -e "base64encode(readall(\"$imgfile\")) |> print"`);
caption = """

A vector and its unit vector. They share the same direction, but the unit vector has a standardized magnitude.

"""
generic_vector =  Mustache.render(gif_to_data_tpl, data=data, caption=caption)

## Vector decomposition

aa = [1,2]
bb = [2,1]
cc = [4,3]
alpha = 2/3
beta = 5/3

vector_decomp = plot(
                     make_arrow(p0, cc, col="black", width=1px),
                     make_arrow(p0, aa, col="black", width=1px),
                     make_arrow(alpha*aa, bb, col="black", width=1px),
                     make_arrow(p0, alpha*aa, col="orange", width=4px, opacity=0.5),
                     make_arrow(alpha*aa, beta*bb, col="orange", width=4px, opacity=0.5),
                     layer(x=[2, .5, 1.75], y=[1.25,1.0,2.25], label=["c","2/3⋅a", "5/3⋅b"], Geom.label)
                     )



imgfile = tempname() * ".png"
io = open(imgfile, "w")
writemime(io, "image/png", vector_decomp)
close(io)

data = readall(`julia4 -e "base64encode(readall(\"$imgfile\")) |> print"`);
caption = L"""

The vector $\langle 4,3 \rangle$ is written as $2/3 \cdot \langle 1,2
\rangle + 5/3 \cdot \langle 2,1 \rangle$. Any vector $\vec{c}$ can be
written uniquely as $\alpha\cdot\vec{a} + \beta \cdot \vec{b}$ provided
$\vec{a}$ and $\vec{b}$ are not parallel.

"""

vector_decomp =  Mustache.render(gif_to_data_tpl, data=data, caption=caption)

## <x,y> -> r theta

vector_rtheta = plot(
                     make_arrow(p0, [2,3], col="black"),
                     make_arrow(p0, [2,0], col="orange"),
                     make_arrow(p0+[2,0], [0,3], col="orange"),
                     layer(x=[.25, 1,1,2], y=[.35, 1.9,.25,1], label=["θ","r", "r ⋅ cos(θ)", "r ⋅ sin(θ)"], Geom.label)
                     )


imgfile = tempname() * ".png"
io = open(imgfile, "w")
writemime(io, "image/png", vector_rtheta)
close(io)

data = readall(`julia4 -e "base64encode(readall(\"$imgfile\")) |> print"`);
caption = L"""

A vector $\langle x, y \rangle$ can be written as $\langle r\cdot
\cos(\theta), r\cdot\sin(\theta) \rangle$ for values $r$ and
$\theta$. The value $r$ is a magnitude, the direction parameterized by
$\theta$.

"""

vector_rtheta =  Mustache.render(gif_to_data_tpl, data=data, caption=caption)

end
