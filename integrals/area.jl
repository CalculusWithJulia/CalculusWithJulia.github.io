module area

using WeavePynb, LaTeXStrings
using Plots
gr()
fig_size = (600, 400)


f(x) = x^2
colors = [:black, :blue, :orange, :red, :green, :orange, :purple]

## Area of parabola

## Area of parabola
function make_triangle_graph(n)
    title = "Area of parabolic cup ..."
    n==1 && (title = "\$\\textrm{Area = }1/2\$")
    n==2 && (title = "\$\\textrm{Area = previous }+ 1/8\$")
    n==3 && (title = "\$\\textrm{Area = previous }+ 2*(1/8)^2\$")
    n==4 && (title = "\$\\textrm{Area = previous }+ 4*(1/8)^3\$")
    n==5 && (title = "\$\\textrm{Area = previous }+ 8*(1/8)^4\$")
    n==6 && (title = "\$\\textrm{Area = previous }+ 16*(1/8)^5\$")
    n==7 && (title = "\$\\textrm{Area = previous }+ 32*(1/8)^6\$")



    plt = plot(f, 0, 1, legend=false, size = fig_size, linewidth=2)
    annotate!(plt, [(0.05, 0.9, text(title,:left))])  # if in title, it grows funny with gr
    n >= 1 && plot!(plt, [1,0,0,1, 0], [1,1,0,1,1], color=colors[1], linetype=:polygon, fill=colors[1], alpha=.2)
    n == 1 && plot!(plt, [1,0,0,1, 0], [1,1,0,1,1], color=colors[1], linewidth=2)
    for k in 2:n
        xs = linspace(0,1,1+2^(k-1))
        ys = map(f, xs)
        k < n && plot!(plt, xs, ys, linetype=:polygon, fill=:black, alpha=.2)
        if k == n
            plot!(plt, xs, ys, color=colors[k], linetype=:polygon, fill=:black, alpha=.2)            
            plot!(plt, xs, ys, color=:black, linewidth=2)
        end
    end
    plt
end



n = 7
anim = @animate for i=1:n
    make_triangle_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


caption = L"""
The first triangle has area $1/2$, the second has area $1/8$, then $2$ have area $(1/8)^2$, $4$ have area $(1/8)^3$, ...
With some algebra, the total area then should be $1/2 \cdot (1 + (1/4) + (1/4)^2 + \cdots) = 2/3$.
"""

archimedes_parabola = gif_to_data(imgfile, caption)


## -------------

# using Gadfly, Reel


# f(x) = x^2
# colors = ["black", "blue", "orange", "red", "green", "orange", "purple"]

# ## Area of parabola

# function make_triangle_graph(n,_)
#     n = convert(Int, n)
#     layers = Layer[]
#     xs = linspace(0,1)
#     append!(layers, layer(x=xs, y=map(f,xs), Geom.line))

    
#     title = "Area of parabolic cup"
#     n==1 && (title = "Area = 1/2")
#     n==2 && (title = "Area = 1/2 + 2 ⋅ (1/2 ⋅ 1/8)")
#     n==3 && (title = "Area = 1/2 + 2 ⋅ (1/2 ⋅ 1/8) + 4 ⋅ (1/2 ⋅ 1/8 ⋅ 1/8)")
#     n==4 && (title = "Area = 1/2 + 2 ⋅ (1/2 ⋅ 1/8) + 4 ⋅ (1/2 ⋅ 1/8 ⋅ 1/8) + 8 ⋅ (1/2 ⋅ 1/8 ⋅ 1/8 ⋅ 1/8)")

#     if n == 0
#         append!(layers, layer(x=[0,0,1],   y=[0,1,1], Geom.line))
#     elseif n == 1
#         append!(layers, layer(x=[1,0,0,1, 0], y=[1,1,0,1,1], Geom.line(preserve_order=true), Theme(default_color=color(colors[1]))))
#     else    
#         for k in (n-1):n
        
#             xs = linspace(0,1,1+2^(k-1))
#             ys = map(f, xs)
#             append!(layers, layer(x=xs, y=ys, Geom.line, Theme(default_color=color(colors[k]))))
#         end
#     end
#     plot(layers...)
# end

# film = roll(make_triangle_graph, fps=1, duration=6)
# film.fps=1
# imgfile = tempname() * ".gif"
# write(imgfile, film)

# caption = """

# Illustration of Archimedes' method of exhaustion to compute the area within a parabolic figure.

# """

# archimedes_parabola = gif_to_data(imgfile, caption)

### Riemann sum picture

## A better picture waits for newer Gadfly with polygon support...


end
