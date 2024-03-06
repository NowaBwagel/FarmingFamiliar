extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var navigation_agent_2d = $NavigationAgent2D

const SPEED = 98.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_vector = ProjectSettings.get_setting("physics/2d/default_gravity_vector")

enum Facing {LEFT, RIGHT, FORWARD, BACKWARD}

var current_facing :Facing = Facing.FORWARD

func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(Vector2(50,50))

func set_movement_target(movement_target:Vector2) ->void:
	navigation_agent_2d.target_position = movement_target

func _unhandled_input(event):
	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		print("Mouse Pressed", get_global_mouse_position())
		set_movement_target(get_global_mouse_position())

func _physics_process(delta):
	_update_animation_state()
	
	if navigation_agent_2d.is_navigation_finished():
		#print("done navigating")
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * SPEED
	_update_facing(velocity.normalized())
	#print(current_agent_position, next_path_position, velocity)
	## Add the gravity.
	#if not is_on_floor():
		#velocity += gravity * gravity_vector * delta
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction : Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_backward", "move_forward")).normalized()
	#_update_facing(direction)
#
	#if direction:
		#velocity = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.y = move_toward(velocity.y, 0, SPEED)


	move_and_slide()


func _update_facing(direction: Vector2)->void:
	if direction.y > 0.5:
		current_facing = Facing.FORWARD
	if direction.y < -0.5:
		current_facing = Facing.BACKWARD
	if direction.x > 0.5:
		current_facing = Facing.RIGHT
	if direction.x < -0.5:
		current_facing = Facing.LEFT
	return

func _update_animation_state()->void:
	if velocity != Vector2.ZERO:
		match (current_facing):
			Facing.FORWARD:
				animation_player.play("walk_forward")
			Facing.BACKWARD:
				animation_player.play("walk_backward")
			Facing.LEFT:
				animation_player.play("walk_left")
			Facing.RIGHT:
				animation_player.play("walk_right")
	else:
		match (current_facing):
			Facing.FORWARD:
				animation_player.play("idle_forward")
			Facing.BACKWARD:
				animation_player.play("idle_backward")
			Facing.LEFT:
				animation_player.play("idle_left")
			Facing.RIGHT:
				animation_player.play("idle_right")
