module center_of_mass

using WeavePynb, LaTeXStrings

## From http://www.wpclipart.com/signs_symbol/roadside_symbols/roadside_3/seesaw.png.html (public domain)
imgfile = "figures/seesaw.png"
caption = L"""

A silhouette of two children on a seesaw. The seesaw can be balanced
only if the distance from the central point for each child reflects
their relative weights, or masses, through the formula $d_1m_1 = d_2
m_2$. This means if the two children weigh the same the balance will
tip in favor of the child farther away, and if both are the same
distance, the balance will tip in favor of the heavier.

"""
seesaw_figure = gif_to_data(imgfile, caption)
                            
end
