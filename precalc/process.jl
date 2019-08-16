using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")

fnames = [
          "calculator",
          "variables",
          "numbers_types",
          "logical_expressions",
          "vectors",
          "ranges",
          "functions",
          "plotting",
          "transformations",
          "inversefunctions",
          "polynomial",
          "polynomial_roots",
          "rational_functions",
          "exp_log_functions",
          "trig_functions",
          "julia_overview"
]


function process_file(nm, twice=false)
    include("$nm.jl")
    mmd_to_md("$nm.mmd")
    markdownToHTML("$nm.md")
    twice && markdownToHTML("$nm.md")
end

process_files(twice=false) = [process_file(nm, twice) for nm in fnames]

"""
## TODO

* the first bit of vectors is a bit rushed

"""
