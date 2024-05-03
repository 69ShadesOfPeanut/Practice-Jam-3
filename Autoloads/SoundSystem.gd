# Script for handling sound
extends Node

# Vars
# Ambience
const OFFICE_COMPUTER_PC_FAN_NOISE_LOOP = preload("res://Sounds/Office Computer PC Fan Noise Loop.wav")


# Automatically starts playing ambience
func _ready():
	print("Ambience loaded up")
	Ambience.set_stream(OFFICE_COMPUTER_PC_FAN_NOISE_LOOP)
	Ambience.play()

# Plays a sound when called
func PlaySound(Sound):
	print("Play sound called")
	SFX.set_stream(Sound)
	SFX.play()

# Stops the sound being played
func StopSound():
	SFX.stop()
