## implement quantum stuff
## krill paper http://arxiv.org/pdf/1403.5821v1.pdf

## This just isn't right...

## Arithmetic for functions
∘(f::Function, g::Function) = x -> f(g(x))

Base.(:+)(f::Function, g::Function) = x -> f(x) + g(x)
Base.(:-)(f::Function, g::Function) = x -> f(x) - g(x)
Base.(:*)(f::Function, g::Function) = x -> f(x) * g(x)
Base.(:*)(c::Number,   g::Function) = x -> c*g(x)
Base.(:*)(f::Function, c::Number) = c * f
Base.(:/)(f::Function, g::Function) = x -> f(x) / g(x)

## f^n = f(f^n-1)...
function Base.(:^)(f::Function, n::Int=1)
    @assert n >= 0
    if n==0
	return identity
    elseif n==1
	return f
    else
	x -> (f ∘ f^(n-1))(x)
    end
end


## Operators
## commutator
commutator(f::Function, g::Function) = f*g - g*f


"shift right and left"
sr(f) = x::Int -> f(x+1)
sl(f) = x::Int -> f(x-1)

## position
X(f::Function) = x -> x*sl(f)(x)

## derivative
D(f::Function) = sr(f) - f
function S(f::Function)
    x::Int -> begin
        x == 0 && return(0)
        x == -1 && return(f(-1))
        sum([f(k) for k in 0:(x-1)])
    end
end

## momentum
P(f::Function) = x -> i * D(f)(x)

function S(f::Function)
    x::Int -> begin
        x == -1 && return(f(x))
        x == 0  && return(0)
        x > 0   && return(sum([f(k) for k in 1:(x-1)]))
        error("x >= -1")
    end
end

# state [x]^n
#poly(n::Int) = (X^n)(x->x)
poly(n::Int) = x -> prod([(x-i) for i in 0:(n-1)])


## verify: [X,P] = i unuh

## D([x]^n) = n * D[x]^(n-1) # seems off by (n+1)/n
## D(f*g) - 

# D(f*g)
# = (f(x+1)*g(x+1) - f(x)*g(x))
# = f(x+1)*g(x+1) - f(x+1)*g(x) + f(x+1)*g(x) - f(x)*g(x)
# = f(x+1) * D(g) + D(f)*g
# = sr(f) * D(g) + D(f)*g
# = s(f)*D(f) + D(f) * g

# D(f/g) = f(x+1)/g(x+1) - f(x)/g(x)
# = (f(x+1) * g(x) - f(x) * g(x+1)) / g(x+1)*g(x)
# = [f(x+1) * g(x) - f(x+1)*g(x+1) + f(x+1)*g(x+1) - f(x)*g(x+1)] / [g(x+1)*g(x)]
# =  (D(f)*g(x+1) - f(x+1) * D(g) )/[g(x+1)*g]
# = [D(f)*s(g) - s(f) * D(g)] / [s(g)*g]


# [X,P](f)(k)
# = (X(P(f)))(x) - P(X(f))(x)
# = X(iD(f))(x) - iD(X(f))(x)
# = i*( x sl(D(f))(x) - D(x*sl(f)(x)))
# = i*(x * sl(f(x+1) - f(x)) - (x+1)(f(x-1+1) - f(x-1)))
# = i*(x * (f(x) - f(x-1)) - (x+1)*(f(x) - f(x-1)))
# = i*(x-(x+1))*(f(x) - f(x-1))
# = -i*D(sl(f))



## What is nicer
function secant(f::Function, a::Real, b::Real)
    x -> begin
        m = (f(a) - f(b)) / (b - a)
        f(a) + m * (x-a)
    end
end
        
        D(f::Function) = x -> f(x+1) - f(x)
        D(f::Function) = function(x) f(x+1) - f(x) end

function secant(f::Function, a::Real, b::Real)
    function(x::Real)
        m = (f(a) - f(b)) / (b - a)
        f(a) + m * (x-a)
    end
    end
    
    ##
    abstract Operator
    type D <: Operator
        f
        D = new(g::Function) f(x) = g(x+1) - g(x)
        end




#####

## Example: forward differences and sums

An **operator** is a function whose domain is comprised of functions and whose output is a function. As an example, we consider the forward difference operator which considers the expression $f(x+1) - f(x)$. We can view this the relation between the function $f$ and the function $x \rightarrow f(x+1) - f(x)$.

In `Julia`, we could define this through

```
D(f::Function) = x -> f(x+1) - f(x)
```

Often this operator is restricted to functions which have integer valued domains. Let's look at $\sin(x)$:

```
D(sin)(1)
```

This should be the same as

```
sin(1+1) - sin(1)
```

As we verified. The calling of this new function requires some pause: `D(sin)(1)` have the `D(sin)` evaluated first. This returns a function, so it makes sense to evaluate this at `1` using the `()` notation to call a function.

We could take `D` twice, Let's see:

```
D(D(sin))(0)
```

Or evaluating it over many values:

```
[D(D(sin))(i) for i in 1:10]
```

A related operator to `D` is the summing operator, `S` which can be defined by how it is evaluated: $S(f)(0) = 0$, $S(f)(1) = f(1)$ and otherwise $S(f)(n) = \sum_{k=0}^{n-1} f(k), n \geq 0$.

In `Julia` we implement this as follows:

```
function S(f::Function)
x::Int -> begin
@assert x >= 0
if x == 0
return(0)
else
return(sum([f(k) for k in 0:x-1]))
end
end
end
```

We have for the function $f(x) = x$:

```
f(x) = x
S(f)(10)
```

This is the sum $0 + 1 + \dots + 9 = 9\dot(10)/2$ using the well-known summation formula. Another well-known summation formula is $1^2 + 2^2 + \dots n^2 = n(n+1)(2n+1)/6$. Wan check that this holds, if we are mindful of the fact that $S$ only sums the first $n-1$ terms:

```
f(x) = x^2
n = 10
n*(n+1)*(2n+1)/6, S(f)(n+1)
```


Why are the two related? It can be shown algebraically, that $S(D(f))(n) = f(n) - f(0)$ and $D(S(f)) = f$. Informally, this is because subtraction (`D`) and addition (`S`) undo each other. Let's verify it for a few functions:

```
f(x) = x^2
D(S(f))(2), S(D(f))(2), f(2)
```

Or for many values:

```
[(D(S(f))(i), S(D(f))(i), f(i)) for i in -3:3]
```


S(D(f))(n)
= D(f)(0) + D(f)(1) + ... + D(f)(n-1)
= f(1) - f(0) + f(2)- f(1) + ... + f(n) - f(n-1) = f(n) - f(0)


D(S(f))(n)
= S(f)(n+1) - S(f)(n)
= f(0) + f(1) + ... + f(n) - [f(0) + f(1) + ... + f(n-1)]
= f(n)

if n = 0 we have D(S(f))(0) = S(f)(1) - S(f)(0) = f(0) - 0 = f(0), as expected.


Let exp(ax) = (1 + a)^x

D(x^n)(x) = (x+1)^n - x^n = (x^n + sum_1^n (n,i)x^(n-i)) - x^n = nx^(n-1) + sum_2^n(n,i)x^(n-1)
D(exp(ax)) = (1+a)^(x+1) - (1+a)^2 = (1+a)^x*(1+a - 1) = a * exp(ax)


Let sr(f)(x) = f(x+1) and sl(f)(x) = f(x-1)

```
sr(f) = x::Int -> f(x+1)
sl(f) = x::Int -> f(x-1)
```

Then define $X(f)(x) = x * sl(f)(x)$ with $X^0(f)=f$ and $X^n$ defined by composition. Then

```
∘(f::Function, g::Function) = x -> f(g(x))
function Base.(:^)(f::Function, n::Int=1)
@assert n >= 0
    if n==0
		return identity
	elseif n==1
		return f
	else
		x -> (f ∘ f^(n-1))(x)
	end
end
```
