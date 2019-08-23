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

process_file(nm) = WeaveTpl.mmd(nm * ".jmd")
process_files(cache=:off) = process_file.(fnames, cache=cache)

"""
## TODO

* the first bit of vectors is a bit rushed

"""
