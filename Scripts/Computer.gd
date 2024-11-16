# Script that handles the computer scene
extends Control

# Vars
# Resources
const MouseClick = preload("res://Sounds/MouseClick.mp3")
const OFFICE_COMPUTER_PC_FAN_NOISE_LOOP = preload("res://Sounds/Office Computer PC Fan Noise Loop.wav")
var SystemTime : Dictionary = Time.get_datetime_dict_from_system()
# Nodes
@onready var DateLabel : Label = get_node("%Date")



func _ready():
	# Sets the date
	DateLabel.set_text(str(SystemTime["day"]) + "/" + str(SystemTime["month"]) + "/" + str(SystemTime["year"]))
	
	# Sets ambience
	Ambience.set_stream(OFFICE_COMPUTER_PC_FAN_NOISE_LOOP)
	Ambience.play()


# Plays typing sounds when pressing keys
func _input(event : InputEvent):
	# If event is key and its just been pressed
	if event is InputEventKey and event.is_pressed():
		#print("Key pressed")
		KeyboardClicks.play()
	# If event is click, then play clicking sound
	elif event.is_action_pressed("LeftClick") or event.is_action_pressed("RightClick"):
		SoundSystem.PlaySound(MouseClick)
