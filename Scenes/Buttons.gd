# Controls buttons
extends HBoxContainer

# Vars
var CurrentQuestion : int = 0
# Stats
var GoodScore : int
var BadScore : int
# Exports
@export var Questions : PackedStringArray
# Nodes
@onready var ScreenNode : Control = get_node("%Screen")
@onready var ScreenText : Label = ScreenNode.get_node("%Text")
@onready var Button1 : Button = get_node("Button")
@onready var Button2 : Button = get_node("Button2")
@onready var ProgressBarNode : ProgressBar = ScreenNode.get_node("%ProgressBar")
@onready var CeilingLight : OmniLight3D = get_node("%CeilingLight")


# Sets the first question into motion
func _ready():
	ScreenText.set_text(Questions[CurrentQuestion])


# Gets button press, adds good or bad score depending on result
func ButtonPress(Result):
	print("Question answered")
	
	# Add score if question isnt the first
	if CurrentQuestion == 0:
		if Result == "No":
			ScreenText.set_text("You have no free will")
			await get_tree().create_timer(0.2).timeout
	else:
		if Result == "Yes":
			GoodScore += 1
		else:
			BadScore += 1
		
		# Print results to console
		print("Result for Question " + str(CurrentQuestion) + ": " + Result)
		print("Good score: " + str(GoodScore) + "\n"\
		+ "Bad score: " + str(BadScore))
	
	# Check question for events
	await QuestionCheck()
	
	CurrentQuestion += 1
	NextQuestion()

# Function to get the next question up
func NextQuestion():
	Button1.disabled = true
	Button2.disabled = true
	
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
func QuestionCheck():
	match CurrentQuestion:
		4:
			print("Question 4 event triggered")
			await get_tree().create_timer(1).timeout
			ScreenText.set_text("Lets test that...")
			await get_tree().create_timer(1.5).timeout
			ScreenText.set_text("...")
			await get_tree().create_timer(1.5).timeout
			hide()
			CeilingLight.hide()
			await get_tree().create_timer(1.5).timeout
			show()
			CeilingLight.show()
