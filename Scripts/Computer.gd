# Script that handles the computer scene
extends Control

# Vars
# Resources
const MouseClick = preload("res://Sounds/MouseClick.mp3")
var SystemTime : Dictionary = Time.get_datetime_dict_from_system()
# Nodes
@onready var DateLabel : Label = get_node("%Date")



func _ready():
	# Sets the date
	DateLabel.set_text(str(SystemTime["day"]) + "/" + str(SystemTime["month"]) + "/" + str(SystemTime["year"]))


# Plays typing sounds when pressing keys
func _input(event : InputEvent):
	# If event is key and its just been pressed
	if event is InputEventKey and event.is_pressed():
		#print("Key pressed")
		KeyboardClicks.play()
	# If event is click, then play clicking sound
	elif event.is_action_pressed("LeftClick") or event.is_action_pressed("RightClick"):
		SoundSystem.PlaySound(MouseClick)
