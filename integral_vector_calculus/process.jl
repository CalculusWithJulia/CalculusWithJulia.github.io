using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
#mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")




fnames = ["polar_coordinates",
          "vectors",
          "vector_valued_functions",
          "scalar_functions",
          "scalar_function_applications",
#          "optimization",
#          "lagrange_multipliers",
          "vector_fields"
#          "double_integrals",
#          "integral_polar_coordinates",
#          "triple_integrals",
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
