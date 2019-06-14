using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
#mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")




fnames = [
          "double_triple_integrals",


#          "parameterized_surfaces",
#          "surface_integrals",
#          "line_integrals",
#          "integral_theorems"
]

function process_file(nm, twice=false)
    include("$nm.jl")
    mmd_to_md("$nm.mmd")
    markdownToHTML("$nm.md")
    twice && markdownToHTML("$nm.md")
end

process_files() = [process_file(nm) for nm in fnames]




"""
## TODO







"""
