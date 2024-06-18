# Script for handling the computer setup part of the game
extends Control

# Vars
# The amount of time the no button has been pressed
var NoPressed : int = 0
var CurrentStage = 0
@onready var StagesSize = Stages.size() - 1
# Export vars
@export_multiline var Stages : PackedStringArray
@export var Titles : PackedStringArray
# Resources
const Fail = preload("res://Sounds/Fail.wav")
const ButtonClickSound = preload("res://Sounds/click.ogg")
const MouseClick = preload("res://Sounds/MouseClick.mp3")
# Nodes
@onready var InstructionsLabel : Label = get_node("%Instructions")
@onready var TitleLabel : Label = get_node("%Title")
@onready var LineEditNode : LineEdit = get_node("%LineEdit")
@onready var ButtonsNode : VBoxContainer = get_node("%Buttons")
@onready var ContinueButton : Button = get_node("%Continue")
@onready var NoButton : Button = get_node("%NoButton")
@onready var NoButtonDecoy : Button = get_node("%NoButtonDecoy")
@onready var NoButtonAnim : AnimationPlayer = get_node("%NoButtonAnim")


func _ready():
	# Put the first stage onto the instructions label
	InstructionsLabel.set_text(Stages[CurrentStage])

# Called when the continue button is pressed
func ContinuePressed():
	# Play button click sound
	SoundSystem.PlaySound(ButtonClickSound)
	
	if CurrentStage >= StagesSize:
		print("Changing scene to Computer")
		get_tree().change_scene_to_file("res://Scenes/Computer.tscn")
		return
	elif CurrentStage == 1:
		var LineEditText = LineEditNode.text
		LineEditText = LineEditText.strip_edges(true, true)
		if LineEditText.is_empty():
			return
	
	CurrentStage += 1
	InstructionsLabel.set_text(Stages[CurrentStage])
	TitleLabel.set_text(Titles[CurrentStage])
	
	match CurrentStage:
		1:
			LineEditNode.set_placeholder("Enter Username...")
			LineEditNode.show()
		2:
			LineEditNode.hide()
			GlobalVars.Username = LineEditNode.text
			#print(GlobalVars.Username)
			ButtonsNode.show()
			ContinueButton.hide()
		3:
			ContinueButton.show()
			ButtonsNode.hide()
	
	#print("Current stage: " + str(CurrentStage))


# Function for when player disagrees with data collection
func NoButtonPressed():
	# Play error sound and force the player to press Yes
	print("No button pressed")
	SoundSystem.PlaySound(Fail)
	
	# No button disappears after a certain amount of clicks
	NoPressed += 1
	if NoPressed >= 8:
		print("No button threshold reached...")
		NoButton.hide()
		NoButtonDecoy.show()
		NoButtonAnim.play("NoButtonDrop")


# Plays typing sounds when pressing keys
func _input(event : InputEvent):
	# If event is key and its just been pressed
	if event is InputEventKey and event.is_pressed():
		#print("Key pressed")
		KeyboardClicks.play()
	elif event.is_action_pressed("LeftClick") or event.is_action_pressed("RightClick"):
		SoundSystem.PlaySound(MouseClick)
