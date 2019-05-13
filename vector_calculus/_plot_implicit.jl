import PyPlot
linspace(a, n=50) = range(a[1], stop=a[2], length=n)

function plot_implicit(F; xrng=(-5,5), yrng=(-5,5), zrng=(-5,5))
   fig = PyPlot.figure()
    ax = fig[:add_subplot](111, projection="3d")
    X, Y, Z = linspace(xrng, 100), linspace(yrng, 100), linspace(zrng,100) # resolution of the contour
    B = linspace(xrng, 15)  # number of slices

    for z in B
        Z1 = [F(x,y,z) for x in X, y in Y]
        X1, Y1 = ndgrid(X,Y)
        ax[:contour](X1, Y1, Z1 .+ z, [z], zdir="z")
    end

    for y in B
        Y1 = [F(x,y,z) for x in X, z in Z]
        X1, Z1 = ndgrid(X, Z)
        ax[:contour](X1, Y1 .+ y, Z1, [y], zdir="y")
    end

    for x in B
        X1 = [F(x,y,z) for y in Y, z in Z]
        Y1, Z1 = ndgrid(Y, Z)
        ax[:contour](X1 .+ x, Y1, Z1, [x], zdir="x")
    end

    ax.set_xlim3d(xrng...)
    ax.set_ylim3d(yrng...)
    ax.set_zlim3d(zrng...)

end


def plot_implicit(fn, bbox=(-2.5,2.5)):
    ''' create a plot of an implicit function
    fn  ...implicit function (plot where fn==0)
    bbox ..the x,y,and z limits of plotted interval'''
    xmin, xmax, ymin, ymax, zmin, zmax = bbox*3
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    A = np.linspace(xmin, xmax, 100) # resolution of the contour
    B = np.linspace(xmin, xmax, 15) # number of slices
    A1,A2 = np.meshgrid(A,A) # grid on which the contour is plotted

    for z in B: # plot contours in the XY plane
        X,Y = A1,A2
        Z = fn(X,Y,z)
        cset = ax.contour(X, Y, Z+z, [z], zdir='z')
        # [z] defines the only level to plot for this contour for this value of z

    for y in B: # plot contours in the XZ plane
        X,Z = A1,A2
        Y = fn(X,y,Z)
        cset = ax.contour(X, Y+y, Z, [y], zdir='y')

    for x in B: # plot contours in the YZ plane
        Y,Z = A1,A2
        X = fn(x,Y,Z)
        cset = ax.contour(X+x, Y, Z, [x], zdir='x')

    # must set plot limits because the contour will likely extend
    # way beyond the displayed level.  Otherwise matplotlib extends the plot limits
    # to encompass all values in the contour.
    ax.set_zlim3d(zmin,zmax)
    ax.set_xlim3d(xmin,xmax)
    ax.set_ylim3d(ymin,ymax)

    plt.show()
