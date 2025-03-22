# Handles first load of the level.
# Puts on the right ambience
extends Node

# Vars
const AMBIENCE_D_19_LOOP = preload("res://Sounds/ambience_d19_loop.ogg")
const OFFICE_COMPUTER_PC_FAN_NOISE_LOOP = preload("res://Sounds/Office Computer PC Fan Noise Loop.wav")
# Nodes
@onready var PCAmbienceNode : AudioStreamPlayer3D = get_node("%PCAmbienceNode")


func _ready():
	# Load background ambience
	Ambience.set_stream(AMBIENCE_D_19_LOOP)
	Ambience.play()
	
	# Load PC ambience
	PCAmbienceNode.set_stream(OFFICE_COMPUTER_PC_FAN_NOISE_LOOP)
	PCAmbienceNode.play()
	print("Office loaded")
