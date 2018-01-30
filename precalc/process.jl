using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")

fnames = [
          "calculator",
          "variables",
          "logical_expressions",
          "numbers_types",
          "vectors", ## XXX the first bit is a bit rushed
          "ranges",
          "functions",
          "plotting",
          "transformations",
          "polynomial",
          "polynomial_roots",
          "rational_functions",
          "trig_functions",
          "julia_overview"
]


[(mmd_to_md("$nm.mmd");markdownToHTML("$nm.md")) for nm in fnames]

# mmd("calculator.mmd")
# mmd("variables.mmd")
# mmd("logical_expressions.mmd")
# mmd("numbers_types.mmd")
# mmd("vectors.mmd") ## XXX the first bit is a bit rushed
# mmd("ranges.mmd")
# mmd("functions.mmd")
# mmd("plotting.mmd")
# mmd("transformations.mmd")
# mmd("polynomial.mmd")
# mmd("polynomial_roots.mmd")
# mmd("rational_functions.mmd")
# mmd("trig_functions.mmd")



# mmd("julia_overview.mmd")
