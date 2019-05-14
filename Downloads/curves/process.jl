using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")


mmd("parameterized_curves.mmd")
mmd("polar_coordinates.mmd") ## XXX start



