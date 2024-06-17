# Script for handling the desktop icon
extends TextureButton

# Vars
# Resources
const ButtonClickSound = preload("res://Sounds/click.ogg")
# Export vars
@export var Icon : Texture2D
@export var IconName : String
@export var App : PackedScene
# Nodes
@onready var LabelNode : Label = get_node("Label")
@onready var OpenApps : Control = get_node("%OpenApps")

# Function for when the function loads up
# Sets all the icons variables
func _ready():
	if Icon != null:
		set_texture_normal(Icon)
	LabelNode.set_text(IconName)

var PressCount := 0
# Function for when the icon is pressed
func Pressed():
	# Plays click sound
	SoundSystem.PlaySound(ButtonClickSound)
	
	
	#print("Self: " + str(self.name) + " | Last click: " + str(GlobalVars.ClickedIcon))
	if PressCount == 1 and GlobalVars.ClickedIcon != self.name:
			print("User clicked another icon")
			GlobalVars.ClickedIcon = self.name
			return
	
	# If pressed once, dont launch.
	# If pressed twice, launch
	if PressCount <= 0:
		GlobalVars.ClickedIcon = self.name
		PressCount += 1
		return
	else:
		PressCount = 0
	
	# Make an instance of app and spawn it
	var AppInstance = App.instantiate()
	AppInstance.set_position(Vector2(300, 300))
	OpenApps.add_child(AppInstance)
