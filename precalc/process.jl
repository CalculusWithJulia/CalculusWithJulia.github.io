using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")

mmd("calculator.mmd")
mmd("variables.mmd")
mmd("logical_expressions.mmd")
mmd("numbers_types.mmd")
mmd("vectors.mmd") ## XXX the first bit is a bit rushed
mmd("ranges.mmd")
mmd("functions.mmd")
mmd("plotting.mmd")
mmd("transformations.mmd")
mmd("polynomial.mmd")
mmd("polynomial_roots.mmd")
mmd("rational_functions.mmd")



mmd("julia_overview.mmd")
