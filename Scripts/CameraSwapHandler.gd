# Script that swaps camera whenever space is pressed
extends Camera3D

# Vars
# Nodes
@onready var DoorCam : Camera3D = get_node("%DoorCam")
@onready var UI : Control = get_node("%UI")


# Handles input
func _input(event):
	if Input.is_action_just_pressed("CamSwap"):
		DoorCam.current =! DoorCam.current
		UI.visible =! UI.visible
