# Getting started with Julia

Julia is a freely available open-source programming language aimed at technical computing.

As it is open source, indeed with a liberal MIT license, it can be
installed for free on many types of computers (though not phones or
tablets). There are some web sites that provide access to `Julia`:

[JuliaBox](www.juliabox.org) provides a web-based interface to `Julia`
built around `IJulia`. An account is needed and can be requested.

[tmpnb](tmpnb.org) This website allows one to use `IJulia` without an account. This makes it super-convenient, though there is no permanent storage of files.

[Sagemath](www.Sagemath.org) provides another web-based solution.
Though different from the more common `IJulia` frontend, the resource is freely available.



### Installing Julia locally

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

```
Verbatim("""
               _
   _       _ _(_)_     |  A fresh approach to technical computing
  (_)     | (_) (_)    |  Documentation: http://docs.julialang.org
   _ _   _| |_  __ _   |  Type "help()" for help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 0.3.6-pre+4 (2015-01-09 16:59 UTC)
 _/ |\__'_|_|_|\__'_|  |  Commit 74acbbf (108 days old release-0.3)
|__/                   |  x86_64-apple-darwin14.0.0

julia> 2 + 2
4
""")
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

1) download and install
  [Anaconda Python](https://store.continuum.io/cshop/anaconda/). (`Python`
  is another open source language which is very popular. The `IPython`
  notebook interface to `Python` is the basis for `IJulia`. `Julia`
  provides a simple interface `Python` that allows many features of
  the `Python` ecosystem to be leveraged. We will use `IJulia` for
  interacting with `julia`; `SymPy` for symbolic mathematics, and
  `PyPlot` for plotting of three-dimensional objects.)

2) Within Julia install the IJulia package:

- open `Julia` by clicking on the icon or typing `julia` at the
  command line

- If this is a new installation, initialize `Julia`'s package
  directory by exceuting the command `Pkg.init()`. (Type that command
  then the "return" key.)

- update the list of available external packages by exceuting the
  command `Pkg.update()`.

- Execute the command: `Pkg.add("IJulia")` by typing that in as
  written and pressing the "return" key.


3) Once installed, `IJulia` can be used by opening `Julia` and
  executing the commands `using IJulia; notebook()`. A shortcut on
  the desktop can also be created.

## Add-on packages

`Julia` has 100s of external, add-on packages that enhance the
offerings of base `Julia`. In these notes, we will rely on a
few of these. These will need to be installed (though most already are
installed for `JuliaBox`.) The following commands will download and install the needed packages:

```
Verbatim("""
Pkg.add("Gadfly")
Pkg.add("SymPy")
Pkg.add("Roots")
Pkg.add("ImplicitEquations")
Pkg.add("PyPlot")
""")
```

The `SymPy` package and the `PyPlot` package require some add-ons for the `Python` environment. These are installed with the Anaconda distribution, though may be added on if another Python environment is used.

## The basics of working with IJulia

The **very** basics of IJulia are covered here.

An `IJulia` notebook is made up of cells. Within a cell a collection of commands may be typed (one or more).

When a cell is executed (by the triangle icon or under the Cell menu) the contents of the cell are evaluated by the `Julia` kernel and any output is displayed below the cell. Typically this is just the output of the last command.

```
2 + 2
3 + 3
```


If the last commands are separated by commas, then a "tuple" will be formed and each output will be displayed separated by commas.

```
2 + 2, 3 + 3
```

Comments can be made in a cell. Anything after a `#` will be ignored.

```
2 + 2  # this is a comment, you can ignore me...
```

Graphics are provided by external packages. There is no built-in
graphing. We primarily use the `Gadfly` package for graphics, though
the initial graphic can take a while to be produced. Here is a plot of
the sine function:

```
using Gadfly    # load the external package, takes a bit of time
plot(sin, 0, 2pi)
```

A few things:

* Cells are numbered in the order they were evaluated.

* This order need not be from top to bottom of the notebook.

* The evaluation of a cell happens within the state of the workspace, which depends on what was evaluated earlier.

* The workspace can be cleared by the "Restart" menu item under
  "Kernel". After restarting the "Run All" menu item under "Cell" can
  be used to re-run all the commands in the notebook. This will also
  reload any packages.
