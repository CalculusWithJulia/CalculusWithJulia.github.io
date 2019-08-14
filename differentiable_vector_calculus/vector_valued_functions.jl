module vector_valued_functions

using WeavePynb
using Plots
pyplot()
using LaTeXStrings

using ForwardDiff
D(f,n=1) = n > 1 ? D(D(f),n-1) : x -> ForwardDiff.derivative(f, x)
Base.adjoint(f::Function) = D(f)         # allow f' to compute derivative

using LinearAlgebra
unzip(vs) = Tuple(eltype(vs[1])[vs[i][j] for i in 1:length(vs)] for j in eachindex(first(vs)))
unzip(r::Function, a, b, n=100) = unzip(r.(range(a, stop=b, length=n)))
function arrow!(plt::Plots.Plot, p, v; kwargs...)
  length(p) == 2 && return quiver!(plt, unzip([p])..., quiver=Tuple(unzip([v])); kwargs...)
  length(p) == 3 && return plot!(plt, unzip([p, p+v])...; kwargs...)
end
arrow!(p, v; kwargs...) = arrow!(Plots.current(), p, v; kwargs...)





end
