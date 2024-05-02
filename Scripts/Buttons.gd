# Controls buttons
extends HBoxContainer

# Vars
@export var CurrentQuestion : int = 0
# Stats
var GoodScore : int
var BadScore : int
# Resources
const OFFICE_DOOR_CLOSE_001 = preload("res://Sounds/Office Door Close-001.wav")
# Exports
@export var ButtonClickSound : Resource
@export var KnockingSound : Resource
@export var SwitchOff : Resource
@export var Questions : PackedStringArray
# Nodes
@onready var ScreenNode : Control = get_node("%Screen")
@onready var ScreenText : Label = ScreenNode.get_node("%Text")
@onready var Button1 : Button = get_node("Button")
@onready var Button2 : Button = get_node("Button2")
@onready var ProgressBarNode : ProgressBar = ScreenNode.get_node("%ProgressBar")
@onready var CeilingLight : OmniLight3D = get_node("%CeilingLight")
@onready var Audio3D : AudioStreamPlayer3D = get_node("%3DAudio")


# Sets the first question into motion
func _ready():
	ScreenText.set_text(Questions[CurrentQuestion])


# Gets button press, adds good or bad score depending on result
func ButtonPress(Result):
	print("Question answered")
	SoundSystem.PlaySound(ButtonClickSound)
	
	# Add score if question isnt the first
	if CurrentQuestion == 0:
		if Result == "No":
			ScreenText.set_text("You have no free will")
			await get_tree().create_timer(0.2).timeout
	elif  CurrentQuestion == 10:
		await Question10Event()
	else:
		if Result == "Yes":
			GoodScore += 1
		else:
			BadScore += 1
		
		# Print results to console
		print("Result for Question " + str(CurrentQuestion) + ": " + Result)
		print("Good score: " + str(GoodScore) + "\n"\
		+ "Bad score: " + str(BadScore))
	
	# Buttons disabled
	Button1.disabled = true
	Button2.disabled = true
	
	# Check question for events
	await QuestionCheck(Result)
	
	CurrentQuestion += 1
	NextQuestion()

# Function to get the next question up
func NextQuestion():
	ScreenText.set_text("...")
	await get_tree().create_timer(1).timeout
	ScreenText.set_text("Please wait...")
	
	# Make progress bar fill up
	ProgressBarNode.show()
	while ProgressBarNode.value < 100:
		ProgressBarNode.value += 1
		await get_tree().create_timer(0.05).timeout
	ProgressBarNode.hide()
	ProgressBarNode.value = 0
	
	ScreenText.set_text(Questions[CurrentQuestion])
	
	Button1.disabled = false
	Button2.disabled = false

# Checks question for if there should be an event
func QuestionCheck(Result):
	match CurrentQuestion:
		4:
			print("Question 4 event triggered")
			await get_tree().create_timer(1).timeout
			ScreenText.set_text("Lets test that...")
			await get_tree().create_timer(1.5).timeout
			ScreenText.set_text("...")
			await get_tree().create_timer(1.5).timeout
			SoundSystem.PlaySound(SwitchOff)
			hide()
			CeilingLight.hide()
			await get_tree().create_timer(5).timeout
			SoundSystem.PlaySound(KnockingSound)
			await get_tree().create_timer(3).timeout
			show()
			CeilingLight.show()
		10:
			print("Question 10 event triggered")
			if Result == "Yes":
				ScreenText.set_text("...")
				await get_tree().create_timer(2).timeout
				ScreenText.set_text("Don't lie to me...")
				await get_tree().create_timer(0.3).timeout


# Question 10 prechoice event
func Question10Event():
	print("Question 10 prechoice event")
	await get_tree().create_timer(1).timeout
	Audio3D.set_stream(OFFICE_DOOR_CLOSE_001)
	Audio3D.play()
