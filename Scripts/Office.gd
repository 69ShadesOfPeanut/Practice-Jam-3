# Handles first load of the level.
# Puts on the right ambience
extends Node

# Vars
const OFFICE_COMPUTER_PC_FAN_NOISE_LOOP = preload("res://Sounds/Office Computer PC Fan Noise Loop.wav")


func _ready():
	Ambience.set_stream(OFFICE_COMPUTER_PC_FAN_NOISE_LOOP)
	Ambience.play()
	print("Ambience loaded up")
