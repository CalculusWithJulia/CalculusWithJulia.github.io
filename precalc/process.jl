using WeaveTpl
fnames = [
          "calculator",
          "variables",
          "numbers_types",
          "logical_expressions",
          "vectors",
          "ranges",
          "functions",
          "plotting",
          "transformations",
          "inversefunctions",
          "polynomial",
          "polynomial_roots",
          "rational_functions",
          "exp_log_functions",
          "trig_functions",
          "julia_overview"
]

process_file(nm; cache=:off) = WeaveTpl.mmd(nm * ".jmd", cache=cache)

function process_files(;cache=:user)
    for f in fnames
        @show f
        process_file(f, cache=cache)
    end
end

"""
## TODO

* the first bit of vectors is a bit rushed

"""
