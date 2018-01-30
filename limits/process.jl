using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")

fnames = [
          "limits",
          "limits_extensions",
          #
          "continuity",
          "intermediate_value_theorem"
          ]




[(mmd_to_md("$nm.mmd");markdownToHTML("$nm.md");markdownToHTML("$nm.md")) for nm in fnames]
