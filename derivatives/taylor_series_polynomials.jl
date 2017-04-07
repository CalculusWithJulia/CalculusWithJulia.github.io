module taylor_series_polynomials

using WeavePynb, LaTeXStrings
using Plots
using SymPy
pyplot()
fig_size = (400, 400)

taylor(f, x, c, n) = removeO(series(f, x, c, n+1))
function make_taylor_plot(u, a, b, k)
    k = 2k
    plot(u, a, b, title="plot of T_$k", linewidth=5, legend=false, size=fig_size, ylim=(-2,2.5))
    if k == 1
        plot!(zero, a, b)
    else
        plot!(taylor(u, x, 0, k), a, b)
    end
end



@vars x
u = 1 - cos(x)
a, b = -2pi, 2pi
n = 8
anim = @animate for i=1:n
    make_taylor_plot(u, a, b, i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


caption = L"""

Illustration of Taylor polynomial of degree $k$, $T_k(x)$, and its graphcial similarity to the graph of the function $1 - cos(x)$.

"""

taylor_animation = gif_to_data(imgfile, caption)




end
