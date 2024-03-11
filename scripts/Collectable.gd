extends Node

@export var collectable_radius: CollectableRadius
@export var harvest_ready_icon: Sprite2D

@export var ready_to_collect:bool = false:
	set(value):
		ready_to_collect = value
		if ready_to_collect:
			if harvest_ready_icon and harvest_ready_icon.is_node_ready():
				_harvest_ready_animation()
		else:
			harvest_ready_icon.visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	collectable_radius.area_entered


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ready_to_collect:
		collectable_radius.monitoring = true


func _harvest_ready_animation():
	harvest_ready_icon.visible = true
	var tween = get_tree().create_tween()
	#tween.tween_property(poplar_tree_sprite, "modulate", Color.RED, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(harvest_ready_icon, "position", Vector2(0,-20), 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(harvest_ready_icon, "position", Vector2(0,-8), 0.85).set_trans(Tween.TRANS_LINEAR)
	#tween.tween_callback(poplar_tree_sprite.queue_free)
	get_tree().create_timer(randf_range(1,1.5)).timeout.connect(_harvest_ready_animation)
