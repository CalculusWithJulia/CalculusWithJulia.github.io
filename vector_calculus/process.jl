using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
#mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")




fnames = ["polar_coordinates",
          "vectors",
          "vector_valued_functions",
#          "vvf_integrals",
          "scalar_functions",
          "derivatives",
          "optimization",
          "lagrange_multipliers",
          "double_integrals",
          "integral_polar_coordinates",
          "triple_integrals",
          "parameterized_surfaces",
          "surface_integrals",
          "line_integrals",
          "integral_theorems"
]

[(mmd_to_md("$nm.mmd");markdownToHTML("$nm.md")g;markdownToHTML("$nm.md")) for nm in fnames]




"""
## TODO







"""
