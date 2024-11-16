# Script to control the GUI
extends Control

# Vars
# Nodes
@onready var TutorialNode : Control = get_node("Tutorial")
@onready var AnimationPlayerNode : AnimationPlayer = get_node("AnimationPlayer")


# Upon load Show the help menu then fade it out
func _ready() -> void:
	TutorialNode.show()
	NodeFade()

# Controls
func _input(event: InputEvent) -> void:
	# Opens control menu for player then fade it out
	if event.is_action_pressed("Controls"):
		print("Controls button pressed")
		TutorialNode.show()
		NodeFade()

# Fade animation
func NodeFade() -> void:
	await get_tree().create_timer(3).timeout
	AnimationPlayerNode.play("Fade")
