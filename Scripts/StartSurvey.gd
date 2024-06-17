# Script that starts the game
extends WindowNode



# Called when user presses yes
# Changes the scene
func YesButtonPressed():
	get_tree().change_scene_to_file("res://Scenes/office.tscn")


# Called when the user presses no
# Closes the window
func NoButtonPressed():
	queue_free()
