module integration_by_parts
using WeavePynb, LaTeXStrings

# using Plots
# pyplot()

# ## parts picture
# u(x) = sin(x*pi/2)
# v(x) = x
# xs = linspace(0, 1)
# a,b = 1/4, 3/4
# p = plot(u, v, 0, 1, legend=false)
# scatter!(p, [u(a), u(b)], [v(a), v(b)], color=:orange, markersize=5)
# plot!(p, [u(a),u(a),0],  [0, v(a), v(a)], color=:orange)
# plot!(p,  [u(b),u(b),0], [0, v(b), v(b)], color=:orange)
# annotate!(p, [(0.65, .25, "A"), (0.4, .55, "B")])
# annotate!(p, [(u(a),v(a) + .08, "(u(a),v(a))"), (u(b),v(b)+.08, "(u(b),v(b))")])

# fname = tempname() * ".png"
# io = open(fname, "w")
# writemime(io, "image/png", p)
# close(io)


# parts_picture=gif_to_data(fname, L"""

# Illustration of integration by parts of the integral $(uv)'$ over
# $[a,b]$ [original](http://en.wikipedia.org/wiki/Integration_by_parts#Visualization). The figure is a parametric plot of $(u,v)$ with the points
# $(u(a), v(a))$ and $(u(b), v(b))$ marked. The difference $u(b)v(b) -
# u(a)v(a) = u(x) \big|_a^b$ is illustrated as the difference of two
# rectangular regions. This area breaks into two pieces, $A$ and $B$,
# partitioned through the curve. If $u$ is increasing and the curve is
# parameterized by $t \rightarrow u^{-1}(t)$, then
# $A=\int_{u^{-1}(a)}^{u^{-1}(b)} v(u^{-1}(t))dt$. A $u$-substitution
# with $t = u(x)$ changes this into the integral $\int_a^b v(x) u'(x)
# dx$. Similarly, for increasing $v$, it can be seen that $B=\int_a^b
# u(x) v'(x) dx$. Combining gives the integration by parts formula.


# """)


# using Gadfly

# ## parts picture
# u(x) = sin(x*pi/2)
# v(x) = x
# xs = linspace(0, 1)
# a,b = 1/4, 3/4
# p = plot(layer(x=map(u,xs), y=map(v,xs),Geom.line),
#          layer(x = [u(a), u(b)], y=[v(a), v(b)], Geom.point),
#          layer(x = [u(a),u(a),0], y = [0, v(a), v(a)], Geom.line(preserve_order=true), Theme(default_color=color("orange"))),
#          layer(x = [u(b),u(b),0], y = [0, v(b), v(b)], Geom.line(preserve_order=true), Theme(default_color=color("orange"))),
#          layer(x = [0.65, 0.4], y = [.25, .55], label=["A", "B"], Geom.label),
#          layer(x = [u(a),u(b)-0.2], y=[v(a), v(b)], label=["(u(a),v(a))", "(u(b), v(b))"], Geom.label)
#          )

# fname = tempname() * ".png"
# io = open(fname, "w")
# writemime(io, "image/png", p)
# close(io)

# parts_picture=gif_to_data(fname, L"""

# Illustration of integration by parts of the integral $(uv)'$ over
# $[a,b]$ [original](http://en.wikipedia.org/wiki/Integration_by_parts#Visualization). The figure is a parametric plot of $(u,v)$ with the points
# $(u(a), v(a))$ and $(u(b), v(b))$ marked. The difference $u(b)v(b) -
# u(a)v(a) = u(x) \big|_a^b$ is illustrated as the difference of two
# rectangular regions. This area breaks into two pieces, $A$ and $B$,
# partitioned through the curve. If $u$ is increasing and the curve is
# parameterized by $t \rightarrow u^{-1}(t)$, then
# $A=\int_{u^{-1}(a)}^{u^{-1}(b)} v(u^{-1}(t))dt$. A $u$-substitution
# with $t = u(x)$ changes this into the integral $\int_a^b v(x) u'(x)
# dx$. Similarly, for increasing $v$, it can be seen that $B=\int_a^b
# u(x) v'(x) dx$. Combining gives the integration by parts formula.


# """)


end
