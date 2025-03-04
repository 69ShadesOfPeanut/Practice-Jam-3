# Script to control the GUI
extends Control

# Vars
var AwaitingTextDisappear : bool = false
# Nodes
@onready var TutorialNode : Control = get_node("Tutorial")
@onready var AnimationPlayerNode : AnimationPlayer = get_node("AnimationPlayer")
@onready var PopupText : Control = get_node("PopupText")
@onready var PopupTextLabel : Label = get_node("%PopupTextLabel")


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
	if AwaitingTextDisappear == true:
		print("Function is already awaiting text disappear. Aborting")
		return
	
	# Set text
	print("Popup text called")
	print("Text given: " + text)
	PopupTextLabel.text = text
	PopupText.show()
	PopupText.modulate.a = 1.0
	
	AwaitingTextDisappear = true
	await get_tree().create_timer(10).timeout
	print("Starting modulation process")
	# Modulate alpha till text is invisible
	while AwaitingTextDisappear == true:
		PopupText.modulate.a -= 0.03
		if PopupText.modulate.a <= 0.0:
			AwaitingTextDisappear = false
			PopupText.hide()
			print("Text popup hidden")
		await get_tree().create_timer(0.1).timeout
