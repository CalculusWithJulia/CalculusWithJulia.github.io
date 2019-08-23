## This can take a while to run
## TODO: only run when [m]md file is newer than html file?


using WeaveTpl

## process top-level files
fnames = ["toc",
          "getting-started-with-julia",
          "quick-notes",
          "julia_interfaces",
          "calculus_with_julia",
          "unicode",
          "bibliography"]


process_file(nm) = WeaveTpl.mmd(nm * ".jmd")

function process_files()
    process_file.(fnames)
    cp("toc.jmd", "README.md", force=true)
    cp("toc.html", "index.html", force=true)
end


## TODO: compile subdirectories
