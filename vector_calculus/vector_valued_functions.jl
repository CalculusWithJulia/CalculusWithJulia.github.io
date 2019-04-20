module vector_valued_functions

using WeavePynb
using Plots
pyplot()
using LaTeXStrings

using ForwardDiff
D(f,n=1) = n > 1 ? D(D(f),n-1) : x -> ForwardDiff.derivative(f, x)
Base.adjoint(f::Function) = D(f)         # allow f' to compute derivative

using LinearAlgebra
xs_ys(vs) = Tuple(eltype(vs[1])[vs[i][j] for i in 1:length(vs)] for j in eachindex(first(vs)))
xs_ys(r::Function, a, b, n=100) = xs_ys(r.(range(a, stop=b, length=n)))
function arrow!(plt::Plots.Plot, p, v; kwargs...)
  length(p) == 2 && return quiver!(plt, xs_ys([p])..., quiver=Tuple(xs_ys([v])); kwargs...)
  length(p) == 3 && return plot!(plt, xs_ys([p, p+v])...; kwargs...)
end
arrow!(p, v; kwargs...) = arrow!(Plots.current(), p, v; kwargs...)





end
