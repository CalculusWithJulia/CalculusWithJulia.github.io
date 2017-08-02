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
    


fnames = [
          "area",
          "ftc",
          
          "substitution",
          "integration_by_parts", 
          "partial_fractions", # XX add in trig integrals (cos()sin() stuff? mx or ^m... XXX
          "improper_integrals", ## 
          "mean_value_theorem",
          "area_between_curves", 
          "center_of_mass",
          "volumes_slice", 
          #"volumes_shell", ## XXX add this in if needed, but not really that excited to now XXX
"arc_length", 
"surface_area"
]




[(mmd_to_md("$nm.mmd");markdownToHTML("$nm.md")) for nm in fnames]

