#-----------------------------------------------------------------------------
# Written by Tag Guillory and TAG Digital Studios, www.raydreams.com
#
# Name :          spring.rb
# Description :   Creates a helical wire
# Author :        Tag Guillory
# Created :       2006-October-06
# Last Update:    2006-October-07
# Notes :         Can be computationally taxing.  Start with less than 10 turns
#                   to determine what your comptuer can handle.  May take minutes
#                   to render large, detailed springs.
#
# History:        1.0 (07.Oct.2006) - created and released
#                 
#
# Usage :         Turns - Total number of rotations of the spring
#                 Spring Height - Total height of the spring's skeletal wire
#                   from tip to tip in the z-axis.  Does not include the wire
#                   diameter.
#                 Spring Radius - Radius of spring.
#                 Wire Radius - Radius of the wire.
#                 Segs/Turn - Segments per turn.  Number of edge segments make
#                   up each turn of the wire.
#                 Circle Segs - Number of segments that make up the perimeter of
#                   the wire.  Default is 24.
# License :       MIT License
#-----------------------------------------------------------------------------
require 'sketchup.rb'

def spring

	# input
	turns = 5
	height = 12.0
	r = 12.0
	wireRadius = 1
	verticesPerTurn = 24
	circleRes = 24
	
	# prompt user for input values
	prompts = ["Turns", "Spring Height", "Spring Radius", "Wire Radius", "Segs/Turn", "Circle Segs"]
	values = [1, 1.feet, 1.feet, 1.inch, 24, 24]
	results = inputbox prompts, values, "Spring Dimensions"
	return if not results
	turns, height, r, wireRadius, verticesPerTurn, circleRes = results
	
	# declare a new array of points
	pts = Array.new
	
	# get the model
	model = Sketchup.active_model
	
	# create the inner spring of edges
	0.upto(verticesPerTurn * turns) do |i|
		
		# calculate the angle
		af = ( i % verticesPerTurn) / (verticesPerTurn * 1.0)
		angle = af * 6.283185307
		
		# calculate the coordinates of the next point
		x = r * Math.cos(angle)
		y = r * Math.sin(angle)
		z = height * ( i / (verticesPerTurn * turns * 1.0))
		
		# add the point
		pts[i] = [x, y, z]
		
		# DEBUG
		#UI.messagebox( "i = #{i}; x = #{x}; y = #{y}; z = #{z}" )
	end
	
	# create the spring path
	spring = model.entities.add_curve(pts)
	
	# create the circle at the start of the spring
	v = Geom::Vector3d.new(pts[1].x - r, pts[1].y, pts[1].z)
	circleEdges = model.entities.add_circle pts[0], v, wireRadius, circleRes
	base = model.entities.add_face(circleEdges)
	base.reverse!
	
	# extrude the  base face
	base.followme(spring)
	
	# erase the spring skeleton
	#model.entities.erase_entities(spring)

end

if( not file_loaded?("spring.rb") )

    add_separator_to_menu("Plugins")
    UI.menu("Plugins").add_item("Spring") { spring }

end

#-----------------------------------------------------------------------------
file_loaded("spring.rb")