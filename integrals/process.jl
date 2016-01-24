using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")

# ## make pages
# mmdtpl="""
# # {{{:TITLE}}}
# """
# jltpl="""
# module {{{:TITLE}}}
# using WeavePynb, LaTeXStrings

# end
# """
# function mmd__XXX(x)
#     y = replace(x, ".mmd", "")
#     io = open(string(y, ".mmd"), "w")
#     Mustache.render(io, mmdtpl, TITLE=y)
#     close(io)
#     io = open(string(y, ".jl"), "w")
#     Mustache.render(io, jltpl, TITLE=y)
#     close(io)
# end
    



mmd("area.mmd")
mmd("ftc.mmd")

mmd("substitution.mmd")
mmd("integration_by_parts.mmd") 
## XXX add in trig integrals (cos()sin() stuff? mx or ^m... XXX
mmd("partial_fractions.mmd") 
mmd("improper_integrals.mmd") ## 

## applications
## XXX Could always add more problems....
mmd("mean_value_theorem.mmd")
mmd("area_between_curves.mmd") 
mmd("center_of_mass.mmd")
mmd("volumes_slice.mmd") 
# mmd("volumes_shell.mmd") ## XXX add this in if needed, but not really that excited to now XXX
mmd("arc_length.mmd") 
mmd("surface_area.mmd") 







