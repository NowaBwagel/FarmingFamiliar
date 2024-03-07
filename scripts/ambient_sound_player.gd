extends AudioStreamPlayer2D

@export var sounds: Array[AudioStream]

@export var frequency: int = 50 # How offen out of 100 should it be making sound
# Called when the node enters the scene tree for the first time.
func _ready():
	_create_timer(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _create_timer(offset:int):
	get_tree().create_timer(offset + randf_range(3, 8)).timeout.connect(_play_sound)

func _play_sound():
	stream = sounds[randi_range(0,sounds.size()-1)]
	playing = true
	
	_create_timer(stream.get_length())
