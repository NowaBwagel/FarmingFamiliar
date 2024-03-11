extends CharacterBody2D

enum Facing {LEFT, RIGHT, FORWARD, BACKWARD}

@onready var animation_player = $AnimationPlayer
@onready var navigation_agent_2d = $NavigationAgent2D

const SPEED = 98.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_vector = ProjectSettings.get_setting("physics/2d/default_gravity_vector")

var current_facing :Facing = Facing.FORWARD
var navigation_movement:bool

func _ready():
	navigation_agent_2d.max_speed = SPEED
	navigation_agent_2d.velocity_computed.connect(_safe_velocity_computed)
	actor_setup()

func actor_setup():
	await get_tree().physics_frame
	
	navigation_movement = false
	
	set_movement_target(Vector2(50,50))

func set_movement_target(movement_target:Vector2) ->void:
	navigation_agent_2d.target_position = movement_target
	#TODO: Clear Nearby actions.

func _unhandled_input(event):
	if (event is InputEventScreenTouch and event.pressed):
		navigation_movement = true

	if (event is InputEventMouseButton and event.pressed) or (event is InputEventScreenTouch and event.pressed):
		print("Mouse Pressed", get_global_mouse_position())
		set_movement_target(get_global_mouse_position())
		if OS.is_debug_build():
			navigation_movement = true

func _input(event):
	if Input.is_action_just_pressed("move_backward") or Input.is_action_just_pressed("move_forward") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		navigation_movement = false

func _physics_process(delta):
	if navigation_movement:
		if navigation_agent_2d.is_navigation_finished():
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
			#TODO: Update Nearby actions.
		else:
			var current_agent_position: Vector2 = global_position
			var next_path_position: Vector2 = navigation_agent_2d.get_next_path_position()
			navigation_agent_2d.velocity = current_agent_position.direction_to(next_path_position) * SPEED
			#print(current_agent_position, next_path_position, velocity)
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity += gravity * gravity_vector * delta
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction : Vector2 = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_backward", "move_forward")).normalized()
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
			
	_update_facing(velocity.normalized())
	_update_animation_state()
	move_and_slide()

func _safe_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity

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


func _on_barn_texture_button_pressed():
	pass # Replace with function body.


func _on_field_texture_button_pressed():
	pass # Replace with function body.


func _on_knapsack_texture_button_pressed():
	$CanvasLayerUI/ViewableContainer.visible = !$CanvasLayerUI/ViewableContainer.visible
