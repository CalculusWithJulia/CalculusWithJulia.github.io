import CwJWeaveTpl: mmd
basedir =  @__DIR__

toplevel = ["toc",
            "getting-started-with-julia",
            "quick-notes",
            "julia_interfaces",
            "calculus_with_julia",
            "unicode",
            "bibliography"]


precalc = [
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

limits = [
          "limits",
          "limits_extensions",
          #
          "continuity",
          "intermediate_value_theorem"
          ]



derivatives = [
          "derivatives", ## more questions
          "numeric_derivatives",

          "mean_value_theorem",
          "optimization",
          "curve_sketching",

          "linearization",
          "newtons_method",
          "lhopitals_rule",  ## Okay - -but could beef up questions..


          "implicit_differentiation", ## add more questions?
          "related_rates",
          "taylor_series_polynomials"
]

integrals = [
          "area",
          "ftc",

          "substitution",
          "integration_by_parts",
          "partial_fractions", # XX add in trig integrals (cos()sin() stuff? mx or ^m... XXX
          "improper_integrals", ##

          "mean_value_theorem",
          "area_between_curves",
          "center_of_mass",
          "volumes_slice",
          #"volumes_shell", ## XXX add this in if needed, but not really that excited to now XXX
          "arc_length",
          "surface_area"
             ]

ODEs =  [
          "odes",
          "euler"
         ]

differentiable_vector_calculus = [
                                "polar_coordinates",
          "vectors",
          "vector_valued_functions",
          "scalar_functions",
          "scalar_functions_applications",
          "vector_fields"
]

integral_vector_calculus =  [
          "double_triple_integrals",
          "line_integrals",
          "div_grad_curl",
          "stokes_theorem",
          "review"
]


fnames = Dict("." => toplevel,
              "precalc" => precalc,
              "limits" => limits,
              "derivatives" => derivatives,
              "integrals" => integrals,
              "ODEs" => ODEs,
              "differentiable_vector_calculus" => differentiable_vector_calculus,
              "integral_vector_calculus" => integral_vector_calculus
              )

dirs = (".", "precalc", "limits", "derivatives", "integrals", "ODEs", "differentiable_vector_calculus", "integral_vector_calculus")


function process_file(dir, f; force=false, cache=:off)
    cd(dir)
    if force || (mtime(f * ".html") < mtime(f * ".jmd"))
        try
            @info "Yes: ---- processing $dir/$f ....."
            mmd(f * ".jmd", cache=cache)
        catch err
            @show "error with $f"
        end
    end
    cd(basedir)
end

function process_files(; force = false, cache=:off)
    for d in dirs
        for f in fnames[d]
            @info "----- process $d/$f? -----"
            process_file(d, f, force=force, cache=cache)
        end
    end

    # move files
    if mtime("README.md") < mtime("toc.jmd")
        cp("toc.jmd", "README.md", force=true)
    end
    if mtime("index.html") < mtime("toc.html")
        cp("toc.html", "index.html", force=true)
    end

end
