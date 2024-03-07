extends Node2D

@export var harvest_amount: int = 1
@export var growth_steps: int = 4
@export var growth_seconds: int = 60
@export var starting_growth_step:int = 0

@export var crop_sprite: Sprite2D
@export var sprite_size: int = 16

var is_crop_ripe: bool = false
var current_growth_step: int:
	set(value):
		current_growth_step = value
		
		if current_growth_step <= growth_steps:
			if crop_sprite.is_inside_tree():
				crop_sprite.region_rect.position.x = sprite_size * current_growth_step
				_growth_animation()
		else:
			if is_crop_ripe:
				#HACK: Add crop spoiling
				if randi_range(0,100) >99:
					queue_free()
			is_crop_ripe = true

func _ready():
	if starting_growth_step != 0: current_growth_step = starting_growth_step - 1
	var seconds_per_step: int = growth_seconds / growth_steps
	
	crop_sprite.material = crop_sprite.material.duplicate(true)
	var offset = float(1.8 * (int(global_position.x) % 4) + 2.5 * (3 - (int(global_position.y) % 4) % 4))
	print (offset)
	crop_sprite.material.set_shader_parameter("offset", offset)
	
	_plant(seconds_per_step)

func _plant(seconds_per_step: int):
	current_growth_step += 1
	get_tree().create_timer(seconds_per_step).timeout.connect(_plant.bindv([seconds_per_step]))

func _growth_animation():
	var tween = get_tree().create_tween()
	#tween.tween_property(poplar_tree_sprite, "modulate", Color.RED, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(crop_sprite, "scale", Vector2(1.2,1.2), 0.5).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(crop_sprite, "scale", Vector2(1,1), 0.5).set_trans(Tween.TRANS_BOUNCE)
