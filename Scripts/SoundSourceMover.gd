extends Node

@export var volumeStep = 3
@export var distance = 5
@export var circleSpeed = 20
@export var audioPlayer: AudioStreamPlayer3D
@export var audioClips: Array[AudioStream]

var audioIndex = 0;
var autoPositionIndex = 0;
var circlePosition: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	playAudio()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var userControls = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	if(userControls.length() > 0):
		circlePosition = 0
		self.position.x = userControls.x * distance
		self.position.z = userControls.y * distance;
	else:
		if(autoPositionIndex == 0):
			circleListener(delta)
		else:
			circlePosition = 0
			# Start with Left Front, then go CCW in 45 degree steps
			var fixedDegree = 45 - (45*(autoPositionIndex-1))
			self.position = degreeToPositionOnCircle(-fixedDegree)
		
	print(self.position)
	
func circleListener(delta):
	circlePosition += circleSpeed * delta;
	self.position = degreeToPositionOnCircle(circlePosition)

	
func degreeToPositionOnCircle(degree):
	var degreeInRad = deg_to_rad(degree-90); #-90 to make 0 = front center
	var pos: Vector3
	pos.x = distance * cos(degreeInRad)
	pos.z = distance * sin(degreeInRad)
	return pos;
	
		
func _input(event):
	if (event is InputEventKey):
		if(event.is_action_pressed("change_position")):
			autoPositionIndex = autoPositionIndex + 1
			autoPositionIndex %= (360/45) + 1
			
		if(event.is_action_pressed("change_sound")):
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
