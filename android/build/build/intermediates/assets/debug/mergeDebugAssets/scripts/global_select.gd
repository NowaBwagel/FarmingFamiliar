extends Node

var picked_node: Node2D:
	set(value):
		picked_node = value
		print("GlobalSelect:picked_node ", picked_node)
