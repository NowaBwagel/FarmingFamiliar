extends Node

@export var sprite: Sprite2D

@onready var area_2d: Area2D = $".."

var entered_area: Area2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.area_entered.connect(_body_entered)
	area_2d.area_exited.connect(_body_exited)

#func _physics_process(delta):
	#if entered_body == null: return
	#
	#var offset:Vector2 = entered_body.global_position - sprite.global_position
	#sprite.skew = -offset.x * deg_to_rad(3)

func _body_entered(area: Area2D):
	entered_area = area
	var tween = get_tree().create_tween()
	#tween.tween_property(poplar_tree_sprite, "modulate", Color.RED, 1).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(sprite, "scale", Vector2(1,0.25), 0.18).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(sprite, "position", Vector2(0,-2), 0.18).set_trans(Tween.TRANS_BOUNCE)
	#tween.tween_property(sprite, "scale", Vector2(1,1), 0.5).set_trans(Tween.TRANS_BOUNCE)

func _body_exited(area: Area2D):
	entered_area = null
	var tween = get_tree().create_tween()
	#tween.tween_property(poplar_tree_sprite, "modulate", Color.RED, 1).set_trans(Tween.TRANS_SINE)
	#tween.tween_property(sprite, "scale", Vector2(1,0.2), 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(sprite, "scale", Vector2(1,1), 0.25).set_trans(Tween.TRANS_BOUNCE)
	tween.parallel().tween_property(sprite, "position", Vector2(0,-8), 0.25).set_trans(Tween.TRANS_BOUNCE)
