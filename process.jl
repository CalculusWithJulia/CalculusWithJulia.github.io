## This can take a while to run


using WeavePynb
using Mustache
mdhtml(fname) = markdownToHTML(fname, BRAND_HREF="toc.html", BRAND_NAME="Calculus with Julia")

## process top-level files
markdownToHTML("toc.md")
cp("toc.md", "README.md", remove_destination=true)
cp("toc.html", "index.html", remove_destination=true)


mdhtml("getting-started-with-julia.md")
mdhtml("bibliography.md")

## XXX This is not working XXX
## ## work in the subdirectories
## cd("precalc") do
##     include("precalc/process.jl")
## end


## cd("limits") do
##     include("process.jl")
## end



## cd("derivatives") do
##     include("process.jl")
## end



## cd("integrals") do
##     include("process.jl")
## end


## ## cd("ODEs") do
## ##     include("process.jl")
## ## end

## cd("curves") do
##     include("process.jl")
## end


## ## cd("series") do
## ##     include("process.jl")
## ## end

## ## cd("vector_calculus") do
## ##     include("process.jl")
## ## end

