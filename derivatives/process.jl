using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")




fnames = [
          "derivatives", ## more questions
          "numeric_derivatives",

          "mean_value_theorem",
          "optimization",
          "curve_sketching",

          "linearization",
          "newtons_method",
          "lhopitals_rule",  ## Okay - -but could beef up questions..


          "implicit_differentiation", ## add more questions?
          "related_rates",
          "taylor_series_polynomials"
]



function process_file(nm, twice=false)
    include("$nm.jl")
    mmd_to_md("$nm.mmd")
    markdownToHTML("$nm.md")
    twice && markdownToHTML("$nm.md")
end

process_files(twice=false) = [process_file(nm, twice) for nm in fnames]




"""
## TODO derivatives

tangent lines intersect at avearge for a parabola

Should we have derivative results: inverse functions, logarithmic differentiation...
"""
