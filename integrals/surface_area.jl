module surface_area

using WeavePynb, LaTeXStrings

# ----

using Plots
gr()
fig_size=(600, 400)

xs,ys = linspace(-1,1), linspace(-1,1)
f(x,y)= 2 - (x^2 + y^2)

dr = [1/2, 3/4]
df = [f(dr[1],0), f(dr[2],0)]

function sa_approx_graph(i)
    p = plot(xs, ys, f, st=[:surface], legend=false)
    for theta in linspace(0, i/10*2pi, 10*i ) 
        path3d!(p,sin(theta)*dr, cos(theta)*dr, df)
    end
    p
end
n = 10
    
anim = @animate for i=1:n
    sa_approx_graph(i)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)


caption = L"""

Surface of revolution of $f(x) = 2 - x^2$ about the $y$ axis. The lines segments are the images of rotating the secant line connecting $(1/2, f(1/2))$ and $(3/4, f(3/4))$. These trace out the frustum of a cone which approximates the corresponding surface area of the surface of revolution. In the limit, this approximation becomes exact and a formula for the surface area of surfaces of revolution can be used to compute the value.

"""

approximate_surface_area = gif_to_data(imgfile, caption)


# -----



imgfile = "figures/gehry-hendrix.jpg"
caption = """

The exterior of the Jimi Hendrix Museum in Seattle has the signature
style of its architect Frank Gehry. The surface is comprised of
patches. A general method to find the amount of material to cover the
surface -- the surface area -- might be to add up the area of the
patches. However, in this section we will see for surfaces of
revolution, there is an easier way. (Photo credit to
[http://firepanjewellery.com/].)
"""

jimi_hendrix_museum = gif_to_data(imgfile, caption)


imgfile = "figures/surface-revolution.png"
caption = L"""

Vase-like figure formed by the rotation of the graph of $x = 2 + \cos(y)$ about the $y$ axis.

Photo credit: [wikipedia](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Surface_of_revolution_illustration.png/188px-Surface_of_revolution_illustration.png).
    """

surface_revolution = gif_to_data(imgfile, caption)





end
