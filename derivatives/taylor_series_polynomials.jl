module taylor_series_polynomials

using WeavePynb, LaTeXStrings
using Plots
using SymPy
gr()
fig_size = (600, 400)

taylor(f, x, c, n) = removeO(series(f, x, c, n+1))
function make_taylor_plot(u, a, b, k)
    k = 2k
    plot(u, a, b, title="plot of T_$k", linewidth=5, legend=false, size=fig_size, ylim=(-2,2.5))
    if k == 1
        plot!(zero, linspace(a, b,100))
    else
        plot!(taylor(u, x, 0, k), linspace(a, b, 100))
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

Illustration of the Taylor polynomial of degree $k$, $T_k(x)$, at $c=0$ and its graph overlayed on that of the function $1 - \cos(x)$.

"""

taylor_animation = gif_to_data(imgfile, caption)




end
