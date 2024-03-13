@tool
class_name CollectableRadius
extends Area2D

@export var starting_radius: int = 10

@onready var collision_shape_2d = $CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready():
	_update_shape_radius(starting_radius)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _update_shape_radius(value: int)->void:
	collision_shape_2d.shape.radius = value
