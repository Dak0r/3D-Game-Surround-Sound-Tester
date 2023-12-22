extends Node

@export var volumeStep = 3
@export var distance = 5
@export var circleSpeed = 20
@export var audioPlayer: AudioStreamPlayer3D
@export var audioClips: Array[AudioStream]

var audioIndex = 0;
var circlePosition: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	playAudio()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var userControls = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	if(userControls.length() > 0):
		self.position.x = userControls.x * distance
		self.position.z = userControls.y * distance;
	else:
		circlePosition += circleSpeed * delta;
		var circlePositionRad = deg_to_rad(circlePosition);
		self.position.x = distance * cos(circlePositionRad)
		self.position.z = distance * sin(circlePositionRad)
		
	print(self.position)
		
func _input(event):
	if (event is InputEventKey):
		
		if(event.is_action_pressed("confirm")):
			audioIndex = audioIndex + 1
			audioIndex %= audioClips.size()
			playAudio()
			
		if(event.is_action_pressed("volume_up")):
			audioPlayer.volume_db += volumeStep
		
		if(event.is_action_pressed("volume_down")):
			audioPlayer.volume_db -= volumeStep
			
func playAudio():
	print("Audio Index: %d" % audioIndex)
	audioPlayer.stream = audioClips[audioIndex]
	audioPlayer.play()
