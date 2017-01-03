The [tiger's tail](http://www.chebfun.org/examples/roots/Tiger.html) is an example for root-finding programs. This oscillating function forms the tail:

```
f(x) = 2*exp(.5*x)* (sin(5*x) + sin(101*x))
```

The `round` function will round the values of `f` up or down to the nearest integer. We want to find the roots between `f` and its "rounded" values:

```
g(x) = f(x) - round(f(x))


Concentrating on $[-2,1]$ there are many roots, in fact more than 250. Knowing this, we instruct the `fzeros` function to use more points in its initial partitioning of the interval:

```
using Roots
rts = fzeros(g, [-2,1], no_pts=10_000)
```

There are 671 "roots" found. Let's check on the size of these roots:

```
[g(x) for x in rts]
```

Why are some $0.5$ or $-0.5$? The `fzeros` function doesn't really find roots, rather it finds places where the function crosses $0$. The function $g(x)$ is discontinuous, so the values corresponding to $0.5$ are jumping points. We can easily filter them out:

```
rts = filter(x -> abs(g(x)) <= 1e-10, rts)
```

Now there  are just 345 actual roots.

The name "tiger's tail" is given, as this plot of the function and the roots layered on top looks like a tiger's tail when the right colors are used.

```
using Plots
xs = linspace(-2, 1, 10_000)
ys = [f(x) for x in xs]
plot(xs, ys, color=:orange)
ys = [f(x) for x in rts]
scatter!(rts, ys, color=:black, markersize=1)
```

