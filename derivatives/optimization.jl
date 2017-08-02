module optimization

using WeavePynb, LaTeXStrings
using Plots
gr()
fig_size = (400, 400)


function perimeter_area_graphic_graph(n)
    h = 1 + 2n
    w = 10-h
    plt = plot([0,0,w,w,0], [0,h,h,0,0], legend=false, size=fig_size,
               xlim=(0,10), ylim=(0,10))
    scatter!(plt, [w], [h], color=:orange, markersize=5)
    annotate!(plt, [(w/2, h/2, "Area=$(round(w*h,1))")])
    plt
end

caption = """ 

Some possible rectangles that satisfy the constraint on the perimeter and their area.

"""
n = 6
anim = @animate for i=1:n
    perimeter_area_graphic_graph(i-1)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

perimeter_area_graphic = gif_to_data(imgfile, caption)


                            
lhopital_40 = gif_to_data("./fcarc-may2016-fig40-300.gif", L"""

Image number $40$ from l'Hospital's calculus book (the first). Among all the cones that can be inscribed in a sphere, determine which one has the largest lateral area. (From http://www.ams.org/samplings/feature-column/fc-2016-05)


""")

                            
lhopital_43 = gif_to_data("./fcarc-may2016-fig43-250.gif", L"""

Image number $43$ from l'Hospital's calculus book (the first). A
traveler leaving location $C$ to go to location $F$ must cross two
regions separated by the straight line $AEB$. We suppose that in the
region on the side of $C$, he covers distance $a$ in time $c$, and
that on the other, on the side of $F$, distance $b$ in the same time
$c$. We ask through which point $E$ on the line $AEB$ he should pass,
so as to take the least possible time to get from $C$ to $F$? (From
\url{http://www.ams.org/samplings/feature-column/fc-2016-05}.)


""")


end
