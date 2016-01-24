Solve the ODE

$$~
y'(t) = 1 - y/t, y(1) = 2
~$$


```
using SymPy
using Plots; immerse()

F(y, t) = 1 - y/t
t0, y0 = 1, 2
vectorfieldplot((t,y) -> 1.0, (t,y) -> F(y,t), xlim=(t0, 5), ylim=(y0-5, y0+5))

t = symbols("t")
y = SymFunction("y")

eqn = dsolve(diff(y(t),t) - F(y(t), t))
ex = rhs(eqn)
C1 = free_symbols(ex)[1]
val = solve(subs(ex, t, t0)-y0)[1]
u = subs(rhs(eqn), C1, val)

plot!(u, t0, 5, linewidth=4)
```

```
y0 = 0
ex = rhs(eqn)
val = solve(subs(ex, t, t0)-y0)[1]
u = subs(rhs(eqn), C1, val)

plot!(u, t0, 5, linewidth=4)
```


```
y0 = -2
ex = rhs(eqn)
val = solve(subs(ex, t, t0)-y0)[1]
u = subs(rhs(eqn), C1, val)

plot!(u, t0, 5, linewidth=4)
```
