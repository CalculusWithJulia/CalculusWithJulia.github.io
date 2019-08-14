## This can take a while to run
## TODO: only run when [m]md file is newer than html file?


using WeavePynb
using Mustache
mdhtml(fname) = markdownToHTML(fname, BRAND_HREF="toc.html", BRAND_NAME="Calculus with Julia")

## process top-level files
markdownToHTML("toc.md")
cp("toc.md", "README.md", force=true)
cp("toc.html", "index.html", force=true)


mdhtml("getting-started-with-julia.md")
mdhtml("quick-notes.md")
mdhtml("julia_interfaces.md")
mdhtml("calculus_with_julia.md")
mdhtml("unicode.md")

mdhtml("bibliography.md")

## TODO: compile subdirectories
