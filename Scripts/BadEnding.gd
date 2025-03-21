# Script for handling the bad ending
extends Node

# Vars
var CanEscape : bool = false
# Resources
const THUNDER_STRIKE = preload("res://Sounds/thunder strike.wav")
const RAIN_ON_ROOF_FROM_INSIDE_1 = preload("res://Sounds/rain on roof from inside 1.wav")
const BAD_ENDING_NEWS_PAPER = preload("res://Textures/BadEnding_NewsPaper.png")
const GOOD_ENDING_NEWS_PAPER = preload("res://Textures/GoodEnding_NewsPaper.png")
# Nodes
@onready var CameraAnimationPlayer : AnimationPlayer = get_node("Camera1/AnimationPlayer")
@onready var Trash_Pills : Node3D = get_node("%Trash_Pills")
@onready var CeilingLight : OmniLight3D = get_node("%CeilingLight")
@onready var Camera2 : Camera3D = get_node("%Camera2")
@onready var Camera1 : Camera3D = get_node("%Camera1")
@onready var LabelAnimationPlayer : AnimationPlayer = get_node("%LabelAnimationPlayer")
@onready var NewsPaper : MeshInstance3D = get_node("%NewsPaper")
@onready var EndingText : Label = get_node("%EndingText")

# Script that runs when the scene loads
func _ready():
	if GlobalVars.Ending == "Good":
		NewsPaper.material_override.set_texture(0, GOOD_ENDING_NEWS_PAPER)
		EndingText.set_text("Ending 1 of 2")
	else:
		NewsPaper.material_override.set_texture(0, BAD_ENDING_NEWS_PAPER)
		EndingText.set_text("Ending 2 of 2")
	
	Ambience.set_stream(RAIN_ON_ROOF_FROM_INSIDE_1)
	Ambience.play()
	
	await get_tree().create_timer(7).timeout
	CameraAnimationPlayer.play("Camera")
	await get_tree().create_timer(4).timeout
	SoundSystem.PlaySound(THUNDER_STRIKE)
	await get_tree().create_timer(0.5).timeout
	CeilingLight.hide()
	Trash_Pills.show()
	await get_tree().create_timer(0.2).timeout
	CeilingLight.show()
	await get_tree().create_timer(0.3).timeout
	CeilingLight.hide()
	await get_tree().create_timer(1).timeout
	CeilingLight.show()


# Called when animation is finished
func AnimationFinished(anim_name):
	await get_tree().create_timer(3).timeout
	Camera2.set_current(true)
	Camera1.set_current(false)
	await get_tree().create_timer(5).timeout
	LabelAnimationPlayer.play("EndingText")
	CanEscape = true

# If the ending animation is finished, go back to computer scene upon user pressing escape
func _unhandled_key_input(event: InputEvent) -> void:
	if event.keycode == KEY_ESCAPE and CanEscape == true:
		print("Transferring to computer scene")
		Ambience.stop()
		get_tree().change_scene_to_file("res://Scenes/Computer.tscn")
	else:
		print("User can't go to computer scene")
