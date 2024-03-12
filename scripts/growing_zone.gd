@tool
extends Node2D

@export var tiling_size: int = 16
@export var width: int = 2
@export var height: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		remove_child(child)
		child.queue_free()
	for x in range(width):
		for y in range(height):
			var marker: Marker2D = Marker2D.new()
			add_child(marker)
			marker.position.x = tiling_size * x
			marker.position.y = tiling_size * y

