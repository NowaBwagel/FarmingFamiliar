@tool
extends Node2D

const PLANTING_SPOT = preload("res://scenes/planting_spot.tscn")

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
			var planting_spot = PLANTING_SPOT.instantiate()
			add_child(planting_spot)
			planting_spot.position.x = tiling_size * x
			planting_spot.position.y = tiling_size * y

