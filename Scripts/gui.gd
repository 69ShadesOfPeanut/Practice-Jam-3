# Script to control the GUI
extends Control

# Vars
var AwaitingTextDisappear : bool = false
# Nodes
@onready var TutorialNode : Control = get_node("Tutorial")
@onready var AnimationPlayerNode : AnimationPlayer = get_node("AnimationPlayer")
@onready var PopupText : Control = get_node("PopupText")
@onready var PopupTextLabel : Label = get_node("%PopupTextLabel")
@onready var PopupTextAnimPlayer : AnimationPlayer = get_node("%PopupTextAnimPlayer")


# Upon load Show the help menu then fade it out
func _ready() -> void:
	TutorialNode.show()
	NodeFade()

# Controls
func _input(event: InputEvent) -> void:
	# Opens control menu for player then fade it out
	if event.is_action_pressed("Controls"):
		# If help is already shown, cancel action
		if TutorialNode.is_visible() or AnimationPlayerNode.is_playing():
			print("Cancelled help menu. Action already occuring")
			return
		
		print("Controls button pressed")
		TutorialNode.modulate = Color(1, 1, 1, 1)
		TutorialNode.show()
		NodeFade()

# Fade animation
func NodeFade() -> void:
	await get_tree().create_timer(3).timeout
	AnimationPlayerNode.play("Fade")

## Put text in the popup text field
func CreatePopupText(text : String):
	# Check if countdown is already happening
	if PopupTextAnimPlayer.is_playing() == true:
		print("Function is already awaiting text disappear. Skipping text")
		SkipText()
		return
	
	# Set text and show popup text
	print("Popup text called")
	print("Text given: " + text)
	PopupTextLabel.text = text
	PopupText.show()
	PopupText.modulate.a = 1.0
	
	
	# Start fade animation
	print("Starting modulation animation")
	PopupTextAnimPlayer.play("PopupTextFade")
	await PopupTextAnimPlayer.animation_finished

## Attempt to skip on screen text
func SkipText():
	print("Skip text called")
	
	PopupTextAnimPlayer.stop()
	
	# Hide GUI element
	PopupText.modulate.a = 0
	PopupText.hide()
