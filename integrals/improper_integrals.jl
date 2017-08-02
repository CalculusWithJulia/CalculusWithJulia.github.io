module improper_integrals
using WeavePynb, LaTeXStrings
using SymPy

using Plots
gr()
fig_size=(600, 400)

function make_sqrt_x_graph(n)

    b = 1
    a = 1/2^n
    xs = linspace(1/2^8, b, 250)
    x1s = linspace(a, b)
    f(x) = 1/sqrt(x)
    val = N(integrate(f, 1/2^n, b))
    title = "area under f over [1/$(2^n), $b] is $(rpad(round(val, 2), 4))"
    
    plt = plot(f, linspace(a, b, 251), xlim=(0,b), ylim=(0, 15), legend=false, size=fig_size, title=title)
    plot!(plt,  [b, a, x1s...], [0, 0, map(f, x1s)...], linetype=:polygon, color=:orange)

    plt

    
end
caption = L"""

Area under $1/\sqrt{x}$ over $[a,b]$ increases as $a$ gets closer to $0$. Will it grow unbounded or have a limit?

"""
n = 10
anim = @animate for i=1:n
    make_sqrt_x_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

sqrt_graph = gif_to_data(imgfile, caption)


end
