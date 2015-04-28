using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")

mmd("limits.mmd")
mmd("limits_extensions.mmd")

mmd("continuity.mmd")
mmd("intermediate_value_theorem.mmd")



