# Script to make lights flicker
extends Light3D

# Vars
## The minimum time between light flickers
@export var MinTime : float
## The maximum time between light flickers
@export var MaxTime : float
## Should the min/max time act as timer between lights flickering off.
## Normally the min/max time counts as both light on and off time
@export var FlickerAlt : bool = false
## The minimum time before light turns back on.
## Only use if flicker alt is enabled
@export var FlickerMinTime : float
## The maximum time before light turns back on.
## Only use if flicker alt is enabled
@export var FlickerMaxTime : float

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
	
	# if flicker alt is enabled, wait an amount of time determined by flicker alt time
	if FlickerAlt == true:
		randomize()
		var FlickerTimeAlt = randf_range(FlickerMinTime, FlickerMaxTime)
		#print("Flicker alt time is: " + str(FlickerTimeAlt))
		await get_tree().create_timer(FlickerTimeAlt).timeout
		visible =! visible
	
	# Repeat the loop
	Flicker()
