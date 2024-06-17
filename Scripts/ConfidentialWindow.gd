# Script that handles password input
extends WindowNode

# Vars
var Password : String = "Password"
# Nodes
@onready var ComputerNode = get_node("/root/Computer")
@onready var PasswordEntryNode : LineEdit = get_node("%PasswordEntry")
@onready var ResultTextNode : Label = get_node("%ResultText")
@onready var OpenApps : Control = ComputerNode.get_node("%OpenApps")
@onready var ProgressBarNode : ProgressBar = get_node("%ProgressBar")
# Resources
const ConfidentialImage = preload("res://Scenes/ComputerApps/ConfidentialImage.tscn")


# Function for when user submits text
func TextSubmitted(Text : String):
	# Check if progress bar is currently loading
	# If it is, then abort
	if ProgressBarNode.visible:
		return
	
	# Clears text entry node
	print("Text submitted: " + Text)
	PasswordEntryNode.clear()
	
	# Checks if the password is correct
	if Text != Password:
		ResultTextNode.set_text("ERROR: Incorrect Password")
		print("User entered wrong password")
		return
	
	# Starts "opening" the file, progresses a progress bar
	ResultTextNode.set_text("Opening file...")
	print("User entered correct password")
	await LoadProgress()
	
	# Spawn in image
	var ImageInstance = ConfidentialImage.instantiate()
	ImageInstance.set_position(Vector2(300, 300))
	OpenApps.add_child(ImageInstance)
	
	# Delete password entry window
	queue_free()


func LoadProgress():
	# Make progress bar fill up
	ProgressBarNode.show()
	while ProgressBarNode.value < 100:
		randomize()
		ProgressBarNode.value += randi_range(1.5, 10)
		await get_tree().create_timer(randf_range(0.05, 0.8)).timeout
	ProgressBarNode.value = 0
