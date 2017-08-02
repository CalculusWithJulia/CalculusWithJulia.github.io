using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")
## uncomment to generate just .md files
mmd(fname) = mmd_to_md(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")




fnames = [
          "derivatives", ## more questions
          
          "mean_value_theorem", ## okay
          "optimization",    ## okay
          "curve_sketching", ## okay
          
          "linearization",   ## Okay
          "newtons_method",  ## Okay
          "lhopitals_rule",  ## Okay - -but could beef up questions..
          
          
          "implicit_differentiation", ## add more questions?
"related_rates",
"taylor_series_polynomials"
]

[(mmd_to_md("$nm.mmd");markdownToHTML("$nm.md")) for nm in fnames]


          

# mmd("derivatives") ## more questions

# mmd("mean_value_theorem.mmd") ## okay
# mmd("optimization.mmd")    ## okay
# mmd("curve_sketching.mmd") ## okay

# mmd("linearization.mmd")   ## Okay
# mmd("newtons_method.mmd")  ## Okay
# mmd("lhopitals_rule.mmd")  ## Okay - -but could beef up questions..


# mmd("implicit_differentiation.mmd") ## add more questions?
# mmd("related_rates.mmd")            
# mmd("taylor_series_polynomials.mmd")

"""
## TODO
tangent lines intersect at avearge for a parabola

Should we have derivative results: inverse functions, logarithmic differentiation...






"""
