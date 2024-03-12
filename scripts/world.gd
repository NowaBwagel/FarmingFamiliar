@tool
extends Node2D

@export var noise: FastNoiseLite

@onready var tile_map = $TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	tile_map.clear()
	var update_cells: Array[Vector2i] = []
	for x in range(128):
		for y in range(128):
			if noise.get_noise_2d(x, y) >= 0.3:
				update_cells.append(Vector2i(x,y))
	tile_map.set_cells_terrain_connect(1, update_cells, 0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
