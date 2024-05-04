# Script to make lights flicker
extends OmniLight3D

# Vars
@export var MinTime : float
@export var MaxTime : float


# Start function
func _ready():
	Flicker()


# Function for flickering the lights
func Flicker():
	randomize()
	var FlickerTime = randf_range(MinTime, MaxTime)
	#print("Flicker time is: " + str(FlickerTime))
	await get_tree().create_timer(FlickerTime).timeout
	visible =! visible
	Flicker()
