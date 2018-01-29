module intermediate_value_theorem

using Plots;
#gr();
pyplot()
fig_size=(400, 400)
using WeavePynb, LaTeXStrings



function IVT_graph(n)
    f(x) = sin(pi*x) + 9x/10
    a,b = [0,3]

    xs = linspace(a,b)


    ## cheat -- pick an x, then find a y
    Δ = .2
    x = linspace(a + Δ,b - Δ,6)[n]
    y = f(x)

    plt = plot(f, a, b, legend=false, size=fig_size)
    plot!(plt, [0,x,x], [f(x),f(x),0], color=:orange, linewidth=3)

    plot

end

n = 6
anim = @animate for i=1:n
    IVT_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


caption = L"""

Illustration of intermediate value theorem. The theorem implies that any randomly chosen $y$
value between $f(a)$ and $f(b)$ will have  at least one $x$ in $[a,b]$
with $f(x)=y$.

"""

IVT = gif_to_data(imgfile, caption)


## -----------------


## Illustrate bisection method

function bisecting_graph(n)
    f(x) = x^2 - 2
    a,b = [0,2]

    err = 2.0^(1-n)
    title = "b - a = $err"
    xs = linspace(a,b)
    plt = plot(f, a, b, legend=false, size=fig_size, title=title)
    
    if n >= 1
        for i in 1:n
            c = (a+b)/2
            if f(a) * f(c) < 0
                a,b=a,c
            else
                a,b=c,b
            end
        end
    end
    plot!(plt, [a,b],[0,0], color=:orange, linewidth=3)
    scatter!(plt, [a,b], [f(a), f(b)], color=:orange, markersize=5, markershape=:circle)

    plt

end


n = 9
anim = @animate for i=1:n
    bisecting_graph(i-1)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


caption = L"""

Illustration of the bisection method to find a zero of a function. At
each step the interval has $f(a)$ and $f(b)$ having opposite signs so
that the intermediate value theorem guaratees a zero.

"""

bisection_graph = gif_to_data(imgfile, caption)


## Include cannonball figure

## http://ej.iop.org/images/0143-0807/33/1/149/Full/ejp405251f1_online.jpg
imgfile = "cannonball.jpg"
cannonball_img = gif_to_data(imgfile, """
Trajectories of potential cannonball fires with air-resistance included. (http://ej.iop.org/images/0143-0807/33/1/149/Full/ejp405251f1_online.jpg)
                             """)



## Hardrock 100
## http://www.therunnerstrip.com/2014/07/hardrock-2014-part-1/

imgfile = "hardrock-100.png"
hardrock_profile =  gif_to_data(imgfile, """
Elevation profile of the  Hardrock 100 ultramarathon. Treating the profile as a function, the absolute maximum is just about 14,000 feet and the absolute minimum about 7600 feet. These are of interest to the runner for different reasons. Also of interest would be each local maxima and local minima---the peaks and valleys of the graph---and the total elevation climbed---the latter so important/unforgettable its value makes it into the chart's title.
                             """)


end
