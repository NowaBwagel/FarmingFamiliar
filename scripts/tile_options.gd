extends VBoxContainer

@export var tile_option_resources: Array[TileOptionResource]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.queue_free()

	if tile_option_resources:
		for tile_option_resource in tile_option_resources:
			var option_button:Button = Button.new()
			option_button.text = tile_option_resource.option_name
			if tile_option_resource.option_callable:
				option_button.pressed.connect(tile_option_resource.option_callable)
			else:
				option_button.pressed.connect(func()->void: print_debug("This feature is not implemented yet... SOORRY"))
