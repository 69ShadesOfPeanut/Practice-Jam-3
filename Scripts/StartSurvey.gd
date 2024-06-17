# Script that starts the game
extends WindowNode


func _ready():
	get_tree().change_scene_to_file("res://Scenes/office.tscn")
