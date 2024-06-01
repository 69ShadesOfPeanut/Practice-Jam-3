# Script for handling sound
extends Node


# Plays a sound when called
func PlaySound(Sound):
	print("Play sound called")
	SFX.set_stream(Sound)
	SFX.play()

# Stops the sound being played
func StopSound():
	SFX.stop()
