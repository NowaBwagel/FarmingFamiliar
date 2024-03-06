extends StaticBody2D

@onready var poplar_tree_sprite = $PoplarTreeSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(3).timeout.connect(_tween_test)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _tween_test():
	var tween = get_tree().create_tween()
	#tween.tween_property(poplar_tree_sprite, "modulate", Color.RED, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(poplar_tree_sprite, "scale", Vector2(1.2,1.2), 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(poplar_tree_sprite, "scale", Vector2(1,1), 0.5).set_trans(Tween.TRANS_BOUNCE)
	#tween.tween_callback(poplar_tree_sprite.queue_free)
	get_tree().create_timer(randf_range(1,1.5)).timeout.connect(_tween_test)
