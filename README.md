# Calculus with Julia

This is a set of notes for learning [calculus](http://en.wikipedia.org/wiki/Calculus). Since the mid 90s there has been a push to teach calculus using many different points of view. The [Harvard](http://www.math.harvard.edu/~knill/pedagogy/harvardcalculus/) style rule of four says that as much as possible the conversation should include a graphical, numerical, algebraic, and verbal component. These notes use the programming language [Julia](http://julialang.org) to illustrate the graphical, numerical, and, at times, the algebraic aspects of calculus.

There are many examples of integrating a computer algebra system (such as `Mathematica`, `Maple`, or `Sage`) into the calculus conversation. Computer algebra systems can be magical. The popular [WolframAlpha](http://www.wolframalpha.com/) website calls the full power of `Mathematica` while allowing an informal syntax that is flexible enough to be used as a backend for Apple's Siri feature. ("Siri what is the graph of x squared minus 4?")
For learning purposes, computer algebra systems model very well the algebraic/symbolic treatment of the material while providing means to illustrate the numeric aspects.  
Theses notes are a bit different in that `Julia` is primarily used for the numeric style of computing and the algebraic/symbolic treatment is added on. Doing the symbolic treatment by hand can be very beneficial while learning, and computer algebra systems make those exercises seem kind of pointless, as the finished product can be produced much easier.

Our real goal is to get at the concepts using technology as much as possible without getting bogged down in the mechanics of the computer language. We feel `Julia` has a very natural syntax that makes the initial start up not so much more difficult than using a calculator. The notes restrict themselves to a reduced set of computational concepts. This set is sufficient for working the problems in mathematics, but do not cover thoroughly many aspects of programming. (Those who are interested can go off on their own and `Julia` provides a rich opportunity to do so.) Within this restricted set, are operators that make many of the computations of calculus reduce to a function call of the form `action(function, arguments...)`. With a small collection of actions that can be composed, many of the problems associated with introductory calculus can be attacked.


These notes are presented in pages covering a fairly focused concept, in a spirit similar to a section of a book. Just like a book, there are try-it-yourself questions at the end of each page. All have self-graded answers.

## Getting started with Julia

Before beginning, we need to get started with Julia. This is akin to going out and buying a calculator, though it won't take as long.

- [Getting Started](getting-started-with-julia.html)

## Precalculus

Many of the necessary computational skills needed for employing `Julia` successfully to assist in learning calculus are in direct analogy to concepts of mathematics that are first introduced in precalculus or prior. This precalculus review, covers some of the basic materials mathematically, but more importantly illustrates the key computational mechanics we will use throughout. A quick rundown of the `julia` concepts alone is [here](precalc/julia_overview.html).

### Number systems

Taking for granted a familiarity with basic calculators, we show in these two sections how `Julia` implements the functionality of a calculator in a manner not so different.

- [Calculator](precalc/calculator.html)

- [Variables](precalc/variables.html)


Calculators really only use one type of number -- floating point numbers. Floating point numbers are a model for the real numbers. However, there are many different sets of numbers in mathematics. Common ones include the integers, rational numbers, real numbers, and complex numbers.  As well, we discuss logical values and vectors of numbers. Though integers are rational numbers, rational numbers are real numbers, and real numbers may be viewed as complex numbers, mathematically, these distinctions serve a purpose. `Julia` also makes these distinctions and more.



- [Number Systems](precalc/numbers_types.html)

- [Inequalities and Boolean Values](precalc/logical_expressions.html)


- [Vectors](precalc/vectors.html)

An arithmetic progression is a sequence of the form $a, a+h, a+2h, \dots, a+kh$. For example $3, 10, 17, 24, .., 52$. They prove very useful in describing collections of numbers. We introduce the range operator that models these within `Julia` and comprehensions that allow one to easily modify the simple sequences.


- [Arithmetic progressions](precalc/ranges.html)

### Functions

The use of functions within calculus is widespread. This section shows how the basic usage within `Julia` follows very closely to common mathematical usage. It also shows that the abstract concept of a function is quite valuable.

- [Functions](precalc/functions.html)

A graphing calculator makes it very easy to produce a graph. `Julia`, using the `Plots` package, makes it even easier and more flexible.

- [Graphs of Functions](precalc/plotting.html)

- [Transformations of Functions](precalc/transformations.html)

#### Polynomials

Polynomials play an important role in calculus. They give a family of functions for which the basic operations are well understood. In addition, they can be seen to provide approximations to functions. This section discusses polynomials and introduces the add-on package `SymPy` for manipulating expressions in `Julia` symbolically. (This package uses the SymPy library from Python.)


- [Polynomials](precalc/polynomial.html)


The roots of a univariate polynomial are the values of $x$ for which $p(x)=0$. Roots are related to its factors. In calculus, the zeros of a derived function are used to infer properties of a function. This section shows some tools in `SymPy` to find factors and roots, when they are available, and introduces the `Roots` package for estimating roots numerically.



- [Polynomial Roots](precalc/polynomial_roots.html)

A rational expression is the ratio of two polynomial expressions. This section covers some additional details that arise when graphing such expressions.

- [Rational Functions](precalc/rational_functions.html)

#### Trigonometric functions

Trigonometric functions are used to describe triangles, circles and oscillatory behaviors. This section provide a brief review.

- [Trigonometric Functions](precalc/trig_functions.html)

## Limits and Continuity

The notion of a limit is at the heart of the two main operations of calculus, differentiation and integration.

- [Limits](limits/limits.html)

- [Examples and extensions of the basic limit definition](limits/limits_extensions.html)


Continuous functions are at the center of any discussion of calculus concepts. These sections define them and illustrate a few implications for continuous functions.

- [Continuity](limits/continuity.html)

- [The Intermediate Value Theorem](limits/intermediate_value_theorem.html), the extreme value theorem and the bisection  method.

## Derivatives

The derivative of a function is a derived function that for each $x$ yields the slope of the *tangent line* of the graph of $f$ at $(x,f(x))$. 

- [Derivatives](derivatives/derivatives.html)


The derivative of a function has certain features. These next sections explore one of the first uses of the derivative -- using its zeros to characterize the original function.

- [The Mean Value Theorem](derivatives/mean_value_theorem.html)


- [Optimization](derivatives/optimization.html)

- [Curve Sketching](derivatives/curve_sketching.html)


The tangent line to the graph of a function at a point has slope given through the derivative. That the tangent line is the best linear approximation to the curve yields some insight to the curve through knowledge of just the tangent lines.

- [Linearization](derivatives/linearization.html)

- [Newton's Method](derivatives/newtons_method.html)

- [L'Hospital's Rule](derivatives/lhopitals_rule.html)

The derivative finds use outside of the traditional way of specifying a function or relationship. These two sections look at some different cases.

- [Implicit Derivatives](derivatives/implicit_differentiation.html)

- [Related Rates](derivatives/related_rates.html)

A generalization of the tangent line as the "best" approximation to a function by a line leads to the concept of the Taylor polynomial.

- [Taylor polynomials](derivatives/taylor_series_polynomials.html)

## Integration

The integral is initially defined in terms of an associated area and then generalized. The Fundamental Theorem of Calculus allows this area to be computed easily through a related function and specifies the relationship between the integral and the derivative.

- [Area](integrals/area.html)

- [The Fundamental Theorem of Calculus](integrals/ftc.html)

Integration is not algorithmic, but rather problems can involve an array of techniques. Many of these are implemented in `SymPy`. Theses sections introduce the main techniques that find widespread usage.

- [Substitution](integrals/substitution.html)

- [Integration by Parts](integrals/integration_by_parts.html) 

- [Partial Fractions](integrals/partial_fractions.html) 

- [Improper Integrals](integrals/improper_integrals.html)

### Applications



Various applications of the integral are presented. The first two sections continue with the idea that an integral is related to area. From there, it is seen that volumes and arc-lengths may be expressed in terms of related integrals.

- [Mean Value Theorem for Integrals](integrals/mean_value_theorem.html)

- [Area between curves](integrals/area_between_curves.html)

- [Center of mass](integrals/center_of_mass.html)

- [Volumes by slicing](integrals/volumes_slice.html)

- [Arc length](integrals/arc_length.html)

- [Surface Area](integrals/surface_area.html)

Ordinary differential equations are an application of integration and the fundamental theorem of calculus.

- [ODEs](ODEs/odes.html)

- [Euler method](ODEs/euler.html)

## Two-dimensional curves

In addition to curves generated by graphs of functions, there are other ways to describe curves in two dimensions. One involves parameterizing both the $x$ and $y$ coordinates by a third variable, such as time. The other, polar curves, describes position in terms of a angle from the positive $x$ axis and a radial distance. 

- [Parametric curves in two dimensions](curves/parameterized_curves.html)

- [Polar Coordinates](curves/polar_coordinates.html) 

## Bibliography

- [Bibliography](bibliography.html)


----



```
alert("""

This is a work in progress. To report an issue, make a comment, or suggest something new, please file an [issue](https://github.com/CalculusWithJulia/CalculusWithJulia.github.io/issues/). In your message add the tag `@jverzani` to ensure it is not overlooked. Otherwise, an email to `verzani` at `math.csi.cuny.edu` will also work.

""")
```


