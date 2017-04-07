## julia -e `include("process.jl")`
## Our "workflow"

## * edit the precalc/*.mmd files
## * run mmd_to_md on them!
## * switch to bookdown and run markdownToRmd
## * run create book on index.Rmd

using WeavePynb

## precalc

fs = readdir()
mds = filter(u -> ismatch(r"^0", u), fs)
for mdfile in mds
    println("Process $mdfile...")
    try
        markdownToRmd(mdfile)
    catch err
        warn("Error with $mdfile")
    end
end



## bookdown
using RCall
R"library(bookdown)"
R"bookdown::render_book('index.Rmd', 'all')"
