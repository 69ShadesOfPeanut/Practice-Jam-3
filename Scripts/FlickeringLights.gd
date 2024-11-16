# Script to make lights flicker
extends Light3D

# Vars
## The minimum time between light flickers
@export var MinTime : float
## The maximum time between light flickers
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
