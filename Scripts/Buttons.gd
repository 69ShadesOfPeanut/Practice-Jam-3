# Controls buttons
extends HBoxContainer

# Vars
@export var CurrentQuestion : int = 0
var State
# Stats
var GoodScore : int
var BadScore : int
var EndingBool : bool = false
# Resources
const OFFICE_DOOR_CLOSE_001 = preload("res://Sounds/Office Door Close-001.wav")
const OFFICE_DOOR_OPEN_003 = preload("res://Sounds/Office Door Open-003.wav")
const MONSTER_BREATHING_SLOWLY_1 = preload("res://Sounds/monster_breathing_slowly_1.wav")
const TELEPHONE = preload("res://Sounds/telephone.mp3")
const PERSON = preload("res://Textures/Person.PNG")
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
@onready var CreepyPainting : MeshInstance3D = get_node("%CreepyPainting")
@onready var ScreenTextureRect : TextureRect = ScreenNode.get_node("%TextureRect")
@onready var FamilyPhoto : MeshInstance3D = get_node("%FamilyPhoto")
@onready var PhoneLight : OmniLight3D = get_node("%PhoneLight")
@onready var PillBottle : Node3D = get_node("%PillBottle")
@onready var Door : Node3D = get_node("%Door")
@onready var Eyes : Node3D = get_node("%Eyes")
@onready var HospitalEquipment : Node3D = get_node("%HospitalEquipment")
@onready var HTTPRequestNode : HTTPRequest = get_node("HTTPRequest")


# Sets the first question into motion
func _ready():
	ScreenText.set_text(Questions[CurrentQuestion])
	
	# Send HTTP request to get ip location
	HTTPRequestNode.request("http://ip-api.com/json/")


# Gets button press, adds good or bad score depending on result
func ButtonPress(Result):
	print("Question answered")
	SoundSystem.PlaySound(ButtonClickSound)
	
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
	
	# Buttons disabled
	Button1.disabled = true
	Button2.disabled = true
	
	# Check question for events
	await QuestionCheck(Result)
	
	if EndingBool == true:
		print("Ending started")
		return
	
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
		randomize()
		ProgressBarNode.value += randi_range(1.5, 10)
		await get_tree().create_timer(randf_range(0.05, 1)).timeout
	ProgressBarNode.hide()
	ProgressBarNode.value = 0
	
	# Check question and assign text
	match CurrentQuestion:
		14:
			if State == null:
				print("State not found")
				ScreenText.set_text(Questions[CurrentQuestion])
				return
			ScreenText.set_text("Do you like it in " + State + "?")
		_:
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
			CreepyPainting.show()
		5:
			CreepyPainting.hide()
		10:
			print("Question 10 event triggered")
			
			await get_tree().create_timer(1).timeout
			FamilyPhoto.show()
			Audio3D.set_stream(OFFICE_DOOR_CLOSE_001)
			Audio3D.play()
			
			# Open door
			Door.set_global_rotation_degrees(Vector3(0, -60, 0))
			
			
			if Result == "No":
				ScreenText.set_text("...")
				await get_tree().create_timer(2).timeout
				ScreenText.set_text("Don't lie to me.")
				await get_tree().create_timer(0.3).timeout
		11:
			FamilyPhoto.hide()
		12:
			print("Question 12 event triggered")
			ScreenText.set_text("...")
			await get_tree().create_timer(2).timeout
			ScreenText.set_text("Are you sure?")
			await get_tree().create_timer(0.3).timeout
			
			HospitalEquipment.show()
		13:
			print("Question 13 event triggered")
			if Result == "Yes":
				ScreenText.set_text("...")
				await get_tree().create_timer(2).timeout
				ScreenText.set_text("Check it.")
				await get_tree().create_timer(0.3).timeout
		15:
			print("Question 14 event triggered")
			ScreenText.set_text("...")
			await get_tree().create_timer(1).timeout
			ScreenTextureRect.show()
			await get_tree().create_timer(1).timeout
			ScreenTextureRect.hide()
		16:
			print("Question 15 event triggered")
			Door.set_global_rotation_degrees(Vector3(0, -180, 0))
			if Result == "No":
				ScreenText.set_text("...")
				await get_tree().create_timer(1).timeout
				ScreenText.set_text("Don't lie.")
				await get_tree().create_timer(0.3).timeout
		18:
			print("Question 17 event triggered")
			if Result == "No":
				ScreenText.set_text("...")
				await get_tree().create_timer(1).timeout
				ScreenText.set_text("Check again.")
				await get_tree().create_timer(0.3).timeout
		23:
			print("Question 22 event triggered")
			ScreenText.set_text("...")
			await get_tree().create_timer(1).timeout
			ScreenText.set_text("You have been this whole time.")
			await get_tree().create_timer(0.3).timeout
			SoundSystem.PlaySound(SwitchOff)
			hide()
			CeilingLight.hide()
			PillBottle.show()
			await get_tree().create_timer(0.7).timeout
			Audio3D.set_stream(OFFICE_DOOR_OPEN_003)
			Audio3D.set_volume_db(10)
			Audio3D.play()
			Eyes.show()
			Door.set_global_rotation_degrees(Vector3(0, -60, 0))
			await get_tree().create_timer(1.5).timeout
			Audio3D.set_stream(MONSTER_BREATHING_SLOWLY_1)
			Audio3D.set_volume_db(3)
			Audio3D.play()
			await get_tree().create_timer(20).timeout
			SoundSystem.PlaySound(TELEPHONE)
			await get_tree().create_timer(12).timeout
			SoundSystem.StopSound()
			Audio3D.stop()
			Eyes.hide()
			show()
			CeilingLight.show()
		27:
			print("Question 26 event triggered")
			if Result == "No":
				ScreenText.set_text("...")
				await get_tree().create_timer(1).timeout
				ScreenText.set_text("Your personal hell")
				await get_tree().create_timer(0.3).timeout
		30:
			print("Question 29 event triggered")
			if Result == "No":
				ScreenText.set_text("...")
				await get_tree().create_timer(1).timeout
				ScreenText.set_text("Too bad")
				await get_tree().create_timer(1).timeout
				ScreenText.set_text("It's time to remember.")
				await get_tree().create_timer(2).timeout
			ScreenText.set_text("...")
			await get_tree().create_timer(2).timeout
			SoundSystem.PlaySound(SwitchOff)
			hide()
			CeilingLight.hide()
			PhoneLight.hide()
			
			EndingBool = true
			await get_tree().create_timer(2).timeout
			Ending()


# Script for handling the ending
func Ending():
	if GoodScore > BadScore:
		print("Good ending")
		GlobalVars.Ending = "Good"
		get_tree().change_scene_to_file("res://Scenes/Endings/BadEnding.tscn")
	else:
		print("Bad ending")
		GlobalVars.Ending = "Bad"
		get_tree().change_scene_to_file("res://Scenes/Endings/BadEnding.tscn")


# On http request complete, save location
func HttpRequestComplete(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var Response = json.get_data()
	
	# If the API request failed, return
	if Response == null or Response["status"] == "fail":
		print("IP lookup failed")
		return
	
	State = Response["regionName"]
	print("Player lives in: " + State)
