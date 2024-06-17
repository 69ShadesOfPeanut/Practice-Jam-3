# Script that closes window nodes when requested
class_name WindowNode
extends Window

# Vars
# Resources
const MouseClick = preload("res://Sounds/MouseClick.mp3")


# When requested to close, delete the node
func _on_close_requested():
	SoundSystem.PlaySound(MouseClick)
	queue_free()

# Plays typing sounds when pressing keys
func _input(event : InputEvent):
	# If event is key and its just been pressed
	if event is InputEventKey and event.is_pressed():
		#print("Key pressed")
		KeyboardClicks.play()
	# If event is click, then play clicking sound
	elif event.is_action_pressed("LeftClick") or event.is_action_pressed("RightClick"):
		SoundSystem.PlaySound(MouseClick)
