## Script that handles the settings
extends Window

# Vars
var MasterBus := AudioServer.get_bus_index("Master")
var SFXBus := AudioServer.get_bus_index("SFX")
var AmbienceBus := AudioServer.get_bus_index("Ambience")
# Nodes
@onready var MasterSlide : HSlider = get_node("%MasterSlider")
@onready var MasterLabel : Label = get_node("%MasterLabel")
@onready var SFXSlider : HSlider = get_node("%SFXSlider")
@onready var AmbienceSlider : HSlider = get_node("%AmbienceSlider")
@onready var SFXLabel : Label = get_node("%SFXLabel")
@onready var AmbienceLabel : Label = get_node("%AmbienceLabel")


## Setup the scene for when it is created
func _ready() -> void:
	# Setup volume sliders
	SFXSlider.value = AudioServer.get_bus_volume_db(SFXBus)
	AmbienceSlider.value = AudioServer.get_bus_volume_db(AmbienceBus)
	# Setup volume labels
	UpdateAudioLabels()

## Called when the volume slider changes.
## Changes the volume
func VolumeSliderChanged(NewVolume: float, VolumeType: String) -> void:
	print(VolumeType + " " + str(NewVolume))
	
	# Change volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(VolumeType), NewVolume)
	# Check if volume is equel to or less than 50. If so, mute bus
	if NewVolume <= -50:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(VolumeType), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index(VolumeType), false)
	# Set label text
	UpdateAudioLabels()

## Update the audio labels
func UpdateAudioLabels():
	SFXLabel.text = "SFX: " + str(AudioServer.get_bus_volume_db(SFXBus) + 50)
	AmbienceLabel.text = "Ambience: " + str(AudioServer.get_bus_volume_db(AmbienceBus) + 50)
	MasterLabel.text = "Master: " + str(AudioServer.get_bus_volume_db(MasterBus) + 50)

## Close window when requested
func CloseRequested() -> void:
	queue_free()
