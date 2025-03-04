## Script that handles player movement and interaction
extends CharacterBody3D


# Vars
@export var Speed : float = 1.0
@export var LookSensitivity : float = 20.0
@export var MinLookAngle : float = -90
@export var MaxLookAngle : float = 90
var MouseDelta : Vector2 = Vector2()
# Nodes
@onready var CameraNode : Camera3D = get_node("Camera3D")
@onready var RayCast3DNode : RayCast3D = get_node("%RayCast3D")
@onready var DeskCamNode : Camera3D = get_node("%DeskCam")
@onready var GuiNode : Control = get_node("%Gui")


## Handle player movement
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * Speed
		velocity.z = direction.z * Speed
	else:
		velocity.x = move_toward(velocity.x, 0, Speed)
		velocity.z = move_toward(velocity.z, 0, Speed)
	
	# Apply movement
	move_and_slide()


## Handles camera input
func GetCameraInput(delta):
	# Rotation on x degrees
	CameraNode.rotation_degrees.x -= MouseDelta.y * LookSensitivity * delta
	# Stop camera from going above or below max/min angle
	CameraNode.rotation_degrees.x = clamp(CameraNode.rotation_degrees.x, MinLookAngle, MaxLookAngle)
	
	# Rotation on y degrees
	rotation_degrees.y -= MouseDelta.x * LookSensitivity * delta
	
	# Clear mouse delta
	MouseDelta = Vector2()

## Gets mouse movement and sets it to mouse delta
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		MouseDelta = event.relative
	if Input.is_action_just_pressed("Interact"):
		Interaction()

## Calls get camera input
func _process(delta: float) -> void:
	GetCameraInput(delta)


## Function called when player is interacting with object
func Interaction():
	# Check if raycast is colliding with anything
	if RayCast3DNode.get_collider() == null:
		return
	
	var ColliderName = RayCast3DNode.get_collider().name
	#print(ColliderName)
	
	# Check what the player is interacting with
	match ColliderName:
		"DeskArea":
			DeskCamNode.current = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		"DoorObject":
			GuiNode.CreatePopupText("Your bedroom door. It feels as if something is pressing hard. You won't do it.")
		"WindowArea":
			GuiNode.CreatePopupText("The outside. It's dark enough to where you can't see 5 feet in front of you. Something or someone could be watching.")
		"BedObject":
			GuiNode.CreatePopupText("Your bed. you can't remember the last time you were in your own bed. You long for the comfort of your own bed.")
		_:
			print(ColliderName)
