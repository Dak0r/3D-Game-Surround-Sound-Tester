extends Node

@export var distance = 5
@export var audioPlayer: AudioStreamPlayer3D
@export var audioNoise: AudioStream
@export var audioSine: AudioStream

var audioIndex = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var confirm =  Input.is_action_just_pressed("confirm")
	self.position.x = velocity.x * distance
	self.position.z = velocity.y * distance;
	print(self.position)
	
	if(confirm):
		audioIndex = audioIndex + 1
		audioIndex %= 2
		print("Audio Index: %d" % audioIndex)
		match audioIndex:
			0:
				audioPlayer.stream = audioNoise
			1:
				audioPlayer.stream = audioSine
		audioPlayer.play()
		
		
