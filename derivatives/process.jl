using WeavePynb
using Mustache

mmd(fname) = mmd_to_html(fname, BRAND_HREF="../toc.html", BRAND_NAME="Calculus with Julia")

mmd("derivatives.mmd") ## more questions

mmd("mean_value_theorem.mmd") ## okay
mmd("optimization.mmd")    ## okay
mmd("curve_sketching.mmd") ## okay

mmd("linearization.mmd")   ## Okay
mmd("newtons_method.mmd")  ## Okay
mmd("lhopitals_rule.mmd")  ## Okay - -but could beef up questions..


mmd("implicit_differentiation.mmd") ## add more questions?
mmd("related_rates.mmd")            
mmd("differential_equations.mmd")

"""
## TODO
tangent lines intersect at avearge for a parabola

Should we have derivative results: inverse functions, logarithmic differentiation...






"""
