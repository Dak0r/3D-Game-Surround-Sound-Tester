extends Node

@export var audioPlayer: AudioStreamPlayer3D

@export var volumeSlider: HSlider
@export var volumeValue: RichTextLabel

@export var planningSlider: HSlider
@export var planningValue: RichTextLabel

var lastVolume
var lastPanning

# Called when the node enters the scene tree for the first time.
func _ready():
	volumeSlider.drag_ended.connect(volumeSliderDragEneded)
	planningSlider.drag_ended.connect(panningSliderDragEneded)
	onVolumeChanged(audioPlayer.volume_db)
	onPanningChanged(audioPlayer.panning_strength)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currentVolume = audioPlayer.volume_db
	if(currentVolume != lastVolume):
		onVolumeChanged(currentVolume)
		
	var currentPanning = audioPlayer.panning_strength
	if(currentPanning != lastPanning):
		onPanningChanged(lastPanning)
		
func _input(event):
	if (event is InputEventKey):
		if(event.is_action_pressed("exit")):
			get_tree().quit()
	
func volumeSliderDragEneded(valueChanged):
	if(!valueChanged):
		pass
	var volume = volumeSlider.value	
	audioPlayer.volume_db = volume
	onVolumeChanged(volume)
	
func panningSliderDragEneded(valueChanged):
	if(!valueChanged):
		pass
	var spread = planningSlider.value
	var panning = 3 - (spread * 3)
	audioPlayer.panning_strength = panning	
	onPanningChanged(panning)
	
func onVolumeChanged(currentVolume):
	volumeValue.text = str(currentVolume)
	volumeSlider.value = currentVolume
	lastVolume = currentVolume

func onPanningChanged(currentPanning):
	var spreadValue = (3 - currentPanning)/3.0
	planningValue.text = str(spreadValue)
	planningSlider.value = spreadValue
	lastPanning = currentPanning
