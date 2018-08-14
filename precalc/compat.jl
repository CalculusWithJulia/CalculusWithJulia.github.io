# our version of compat
import Compat: range
import Compat: MathConstants.γ, MathConstants.e, MathConstants.φ, MathConstants.catalan, MathConstants.ℯ
import Compat: LinearAlgebra


# # in v0.7 linspace is no longer the main interface here
# function Base.range(start; step=nothing, stop=nothing, length=nothing)
#     have_step = step !== nothing
#     have_stop = stop !== nothing
#     have_length = length !== nothing
    
#     if !(have_stop || have_length)
#         throw(ArgumentError("At least one of `length` or `stop` must be specified"))
#     elseif have_step && have_stop && have_length
#         throw(ArgumentError("Too many arguments specified; try passing only one of `stop` or `length`"))
#     elseif start === nothing
#             throw(ArgumentError("Can't start a range at `nothing`"))
#         end
    
#         if have_stop && !have_length
#             return have_step ? (start:step:stop) : (start:stop)
#         elseif have_length && !have_stop
#             return have_step ? Base.range(start, step, length) : Base.range(start, length)
#         elseif !have_step
#             return linspace(start, stop, length)
#         end
# end
