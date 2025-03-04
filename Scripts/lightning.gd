## Script that makes lightning flash randomly
extends OmniLight3D

# Vars
# Resources
const thunder = preload("res://Sounds/thunder strike.wav")
# Exports
@export var MinTime : float = 1
@export var MaxTime : float = 5
# Nodes
@onready var TimerNode : Timer = get_node("Timer")


## Starts the timer and sets a random var
func _ready() -> void:
	randomize()
	TimerNode.start(randf_range(MinTime, MaxTime))
	print("Time left on lightning: " + str(TimerNode.time_left))

## When timer runs out start new one
func TimerTimeout() -> void:
	visible = true
	SoundSystem.PlaySound(thunder)
	await get_tree().create_timer(0.3).timeout
	visible = false
	
	randomize()
	TimerNode.start(randf_range(MinTime, MaxTime))
	print("Time left on lightning: " + str(TimerNode.time_left))
