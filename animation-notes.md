## Basic template for an animation:


using LaTeXStrings
using WeavePynb

using Plots
pyplot(); fig_size = (400, 300) 


n = 8
anim = @animate for i=1:n
  plot(..., size=fig_size, legend=false)
  plot!(...)
  scaater!(...)
  annontate!(...)
end

imgfile = tempname() * ".gif"
gif(anim, imgfile, fps = 1)

caption = L"""
Some caption
"""

xva_trajectory =  WeavePynb.gif_to_data(imgfile, caption)
