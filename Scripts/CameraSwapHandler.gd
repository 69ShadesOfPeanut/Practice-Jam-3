# Script that swaps camera whenever space is pressed
extends Camera3D

# Vars
# Nodes
@onready var DoorCam : Camera3D = get_node("%DoorCam")
@onready var PlayerCharacter : CharacterBody3D = get_node("%PlayerCharacter")


## Handles input
func _input(event):
	if Input.is_action_just_pressed("CamSwap"):
		# Check if player is currently off desk
		if PlayerCharacter.get_node("Camera3D").current == true:
			return
		
		DoorCam.current =! DoorCam.current
	if Input.is_action_just_pressed("GetUp"):
		# Check if door cam is active
		# If active, don't let player stand up
		if DoorCam.current == true:
			return
		
		print("Player gets up")
		# Change camera
		PlayerCharacter.get_node("Camera3D").current = true
		# Capture mouse
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
