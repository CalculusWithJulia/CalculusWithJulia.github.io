# Getting started with Julia

Julia is a freely available open-source programming language aimed at technical computing.

As it is open source, indeed with a liberal MIT license, it can be
installed for free on many types of computers (though not phones or
tablets). 


We recommend taking advantage of
[JuliaBox](http://www.juliabox.org), which  provides a web-based interface to `Julia`
built around `Jupyter`, a wildly succesful platform for interacting
with different open-source software programs. For JuliaBox, a Google account is needed. 


### Installing Julia locally

Julia Box is great and convenient, but it but may not be available to
you. In that case, installing `Julia` is a not-so-difficult option.


Binaries of `Julia` are provided at
[julialang.org](http://julialang.org/downloads/). Julia has an
official released version and a developmental version. Unless there is
a compelling reason, the latest released version should be downloaded
and installed for use.

The base `Julia` provides a *command-line interface*, or REPL
(read-evaluate-parse).

### Basic interactive usage

Once installed, `Julia` can be started by clicking on an icon or
typing `julia` at the command line. Either will open a *command line
interface* for a user to interact with a `Julia` process. The basic
workflow is easy: commands are typed then sent to a `Julia` process
when the "return" key is pressed for a complete expression. Then the
output is displayed.


A command is typed following the *prompt*. An example might be `2 + 2`. To send the command to the `Julia` interpreter the "return" key is pressed. A complete expression or expressions will then be parsed and evaluated (executed). If the expression is not complete, `julia`'s prompt will still accept input to complete the expression. Type `2 +` to see. (The expression `2 +` is not complete, as the infix operator `+` expects two arguments, one on its left and one on its right.)

```verbatim
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: https://docs.julialang.org
   _ _   _| |_  __ _   |  Type "?help" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.6.0 (2017-06-19 13:05 UTC)
 _/ |\__'_|_|_|\__'_|  |  Official http://julialang.org/ release
|__/                   |  x86_64-apple-darwin13.4.0

julia> 2 + 2
4
```


Above, `julia>` is the prompt.  These notes will not include the
prompt, so that copying-and-pasting can be more easily used. Input and
output cells display similarly, though with differences in
coloring. For example:

```
2 + 2
```

### IJulia, a better learning enviroment for `Julia`

A more forgiving interface for learning is provided through the
`IJulia` interface. This is the interface for `JuliaBox`. The `IJulia`
interface can be installed relatively easily by following these steps:

* Run these commands to install two packages:

```verbatim
Pkg.update()
Pkg.add("PyCall")
Pkg.add("IJulia")
```

* Once this is done, you can start the notebook with these commands:

```verbatim
using IJulia
notebook()
```


## Add-on packages

`Julia` has 100s of external, add-on packages that enhance the
offerings of base `Julia`. The above showed how to add two packages to
a system. In these notes, we will rely on a few packages. These will
need to be installed. The following commands will download and install the
main packages we reference:

```verbatim
Pkg.update()
Pkg.add("Plots")
Pkg.add("SymPy")
Pkg.add("Roots")
Pkg.add("ImplicitEquations")
""")
```

The `SymPy` package requires some add-ons for the `Python`
environment, which should be installed automatically if not found on
your system.

## The basics of working with IJulia

The **very** basics of IJulia are covered here.

An `IJulia` notebook is made up of cells. Within a cell a collection of commands may be typed (one or more).

When a cell is executed (by the triangle icon or under the Cell menu) the contents of the cell are evaluated by the `Julia` kernel and any output is displayed below the cell. Typically this is just the output of the last command.

```
2 + 2
3 + 3
```


If the last commands are separated by commas, then a "tuple" will be formed and each output will be displayed, separated by commas.

```
2 + 2, 3 + 3
```

Comments can be made in a cell. Anything after a `#` will be ignored.

```
2 + 2  # this is a comment, you can ignore me...
```

Graphics are provided by external packages. There is no built-in
graphing. We use the `Plots` package and its default backend. The
`Plots` package provides a common interface to several different
backends, so this choice is easily changed. The `GR` backend and
`plotly` backend are used in these notes.


```
using Plots
```

With that in hand, to make a graph of a function over a range, we follow this pattern:

```
plot(sin, 0, 2pi)
```

A few things:

* Cells are numbered in the order they were evaluated.

* This order need not be from top to bottom of the notebook.

* The evaluation of a cell happens within the state of the workspace,
  which depends on what was evaluated earlier.

* The workspace can be cleared by the "Restart" menu item under
  "Kernel". After restarting the "Run All" menu item under "Cell" can
  be used to re-run all the commands in the notebook. This will also
  reload any packages.
