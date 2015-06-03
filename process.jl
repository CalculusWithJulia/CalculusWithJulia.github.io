## This can take a while to run


using WeavePynb
using Mustache
mdhtml(fname) = markdownToHTML(fname, BRAND_HREF="toc.html", BRAND_NAME="Calculus with Julia")

## process top-level files
markdownToHTML("toc.md")
run(`cp toc.md README.md`)
run(`cp toc.html index.html`)

mdhtml("getting-started-with-julia.md")
mdhtml("bibliography.md")

## work in the subdirectories
cd("precalc") do
    reload("process.jl")
end


cd("limits") do
    reload("process.jl")
end



cd("derivatives") do
    reload("process.jl")
end



cd("integrals") do
    reload("process.jl")
end

cd("series") do
    reload("process.jl")
end



cd("vector_calculus") do
    reload("process.jl")
end

