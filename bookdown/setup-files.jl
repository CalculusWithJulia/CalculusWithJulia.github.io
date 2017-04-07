precalc = [
           "calculator.md",
           "variables.md",
           "logical_expressions.md",
           "numbers_types.md",
           "vectors.md" ,
           "ranges.md",
           "functions.md",
           "plotting.md",
           "transformations.md",
           "polynomial.md",
           "polynomial_roots.md",
           "rational_functions.md",
           "trig_functions.md"
           ]


limits = [
          "limits.md",
          "limits_extensions.md",
          "continuity.md",
          "intermediate_value_theorem.md"
          ]



derivatives = [
               "derivatives.md",
               "mean_value_theorem.md", 
               "optimization.md",    
               "curve_sketching.md", 
               "linearization.md",   
               "newtons_method.md",  
               "lhopitals_rule.md",  
               "implicit_differentiation.md",
               "related_rates.md",            
"differential_equations.md"
]


integrals = [
             "area.md",
             "ftc.md",
             "substitution.md",
             "integration_by_parts.md", 
             "partial_fractions.md", 
             "improper_integrals.md", 
             "mean_value_theorem.md",
             "area_between_curves.md", 
             "center_of_mass.md",
             "volumes_slice.md", 
             "arc_length.md", 
             "surface_area.md"
]

odes = [
        "odes.md",
        "euler.md"]



curves = [
          "parameterized_curves.md",
          "polar_coordinates.md"
          ]


m = [(precalc, "precalc", "00"),
     (limits, "limits", "10"),
     (derivatives, "derivatives", "20"),
     (integrals, "integrals", "30"),
     (odes, "ODEs", "40"),
#     (multi, "multi", "50"),
     (curves, "curves", 60)
     ]

for (fs, dname, prefix) in m
    ctr = 5
    for fname in fs
        cnt = lpad(ctr,2,"0")
        ctr = ctr + 5
        onm = "../$dname/$fname"
        nnm = "0$prefix$cnt-$fname"
        run(`ln -sf $onm $nnm `)
    end
end




