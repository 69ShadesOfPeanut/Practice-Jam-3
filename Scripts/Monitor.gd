# Script that allows the monitor to show the UI
extends Node3D

# Vars
@onready var ViewportNode : SubViewport = get_node("SubViewport")
@onready var Screen : MeshInstance3D = get_node("Screen")

func _ready():
	# Clear viewport
	ViewportNode.set_clear_mode(SubViewport.CLEAR_MODE_ONCE)
	
	# Set screen texture to viewport
	Screen.material_override.albedo_texture = ViewportNode.get_texture()
