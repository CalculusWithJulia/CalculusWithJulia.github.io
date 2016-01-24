module intermediate_value_theorem

using Gadfly, Reel
using WeavePynb, LaTeXStrings

## Illustrate intermediate value theorem
function IVT_graph(n,_)
    f(x) = sin(pi*x) + 9x/10
    a,b = [0,3]

    xs = linspace(a,b)


    ## cheat -- pick an x, then find a y
    Δ = .2
    x = linspace(a + Δ,b - Δ,6)[convert(Int, n) + 2]
    y = f(x)
    
    plot(layer(x=xs, y=map(f,xs), Geom.line),
         layer(x=[0,x,x], y=[f(x),f(x),0], Geom.line, Theme(default_color=colorant"orange", line_width=3px))
         )

end

film = roll(IVT_graph, fps=1, duration=6)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)

caption = L"""

Illustration of intermediate value theorem. The theorem implies that any randomly chosen $y$
value between $f(a)$ and $f(b)$ will have  at least one $x$ in $[a,b]$
with $f(x)=y$.

"""

IVT = gif_to_data(imgfile, caption)


## Illustrate bisection method

function bisecting_graph(n,_)
    f(x) = x^2 - 2
    a,b = [0,2]

    xs = linspace(a,b)
    l = layer(x=xs, y=map(f,xs), Geom.line)
    
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
    plot(l,
         layer(x=[a,b],y=[0,0], Geom.line, Theme(default_color=colorant"orange", line_width=3px)),
         layer(x=[a,b],y=[f(a), f(b)], Geom.point, Theme(default_color=colorant"orange"))
         )

end

film = roll(bisecting_graph, fps=1, duration=9)
film.fps=1
imgfile = tempname() * ".gif"
write(imgfile, film)

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



end
