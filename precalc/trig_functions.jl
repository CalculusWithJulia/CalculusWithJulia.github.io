module trig_functions

using WeavePynb
using LaTeXStrings
using Plots
gr() #pyplot()
fig_size = (400, 300)

function plot_angle(m)
    r = m*pi
    
    ts = linspace(0, 2pi, 100)
    tit = "$m * pi -> ($(round(cos(r), 2)), $(round(sin(r), 2)))"
    p = plot(cos.(ts), sin.(ts), legend=false, aspect_ratio=:equal,title=tit)
    plot!(p, [-1,1], [0,0], color=:gray30)
    plot!(p,  [0,0], [-1,1], color=:gray30)
    
    if r > 0
        ts = linspace(0, r, 100)
    else
        ts = linspace(r, 0, 100)
    end

    plot!(p, (1/2 + abs.(ts)/10pi).* cos.(ts), (1/2 + abs.(ts)/10pi) .* sin.(ts), color=:red, linewidth=3)
    l = 1 #1/2 + abs(r)/10pi
    plot!(p, [0,l*cos(r)], [0,l*sin(r)], color=:green, linewidth=4)

    scatter!(p, [cos(r)], [sin(r)], markersize=5)
    annotate!(p, [(1/4+cos(r), sin(r), "(x,y)")])
    
    p
end
    


## different linear graphs
anim = @animate for m in  -4//3:1//6:10//3
    plot_angle(m)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)
caption = "An angle in radian measure corresponds to a point on the unit circle, which defines the sine and cosine of the angle."
radian_to_trig =  gif_to_data(imgfile, caption)




end
