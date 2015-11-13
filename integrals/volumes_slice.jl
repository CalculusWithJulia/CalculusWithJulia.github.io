module volumes_slice
using WeavePynb, LaTeXStrings


# using Reel
# import PyPlot



# function make_rotate_graph(n,_)
#     PyPlot.pygui(false)
#     n = convert(Int, n) + 1
#     ## Spherical
#     X(r,theta,phi) = r * sin(theta) * sin(phi)
#     Y(r,theta,phi) = r * sin(theta) * cos(phi)
#     Z(r,theta,phi) = r * cos(theta)
    
#     thetas = linspace(0, pi, 250)
#     phis   = linspace(0, pi/2*(n/10),250)
#     xs = [X(1, theta, phi) for theta in thetas, phi in phis]
#     ys = [Y(1, theta, phi) for theta in thetas, phi in phis]
#     zs = [Z(1, theta, phi) for theta in thetas, phi in phis]
    
#     p = PyPlot.plot_surface(xs, ys, zs)
#     PyPlot.gcf()
# end

# film = roll(make_rotate_graph, fps=1, duration=6)
# film.fps=1
# imgfile = tempname() * ".gif"
# write(imgfile, film)

# caption = L"""

# Illustration of rotating a curve around the $y$-axis to create a 3-dimensional figure.

# """

# rotate_graph = gif_to_data(imgfile, caption)


end
