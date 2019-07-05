# SketchUp-Spring
This is a simple Sketch 3D Ruby Plugin I wrote ages ago to create springs

It's dependency is obviously on the Sketch 3D API. I don't even know if that is supported any more.

It was to draw 3D string with a few parameters

 Usage :         Turns - Total number of rotations of the spring
                 Spring Height - Total height of the spring's skeletal wire
                   from tip to tip in the z-axis.  Does not include the wire
                   diameter.
                 Spring Radius - Radius of spring.
                 Wire Radius - Radius of the wire.
                 Segs/Turn - Segments per turn.  Number of edge segments make
                   up each turn of the wire.
                 Circle Segs - Number of segments that make up the perimeter of
                   the wire.  Default is 24.
