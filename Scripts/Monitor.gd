# Script that allows the monitor to show the UI
# Screen interaction code taken from godot GUI in 3D demo
extends Node3D

# Vars
# Used for checking if the mouse is inside the Area3D
var IsMouseInside = false
# The last processed input touch/mouse event. To calculate relative movement
var LastEventPos2D = null
# The time of the last event in seconds since engine start
var LastEventTime : float = -1.0
# Nodes
@onready var ViewportNode : SubViewport = get_node("SubViewport")
@onready var Screen : MeshInstance3D = get_node("Screen")
@onready var AreaNode : Area3D = get_node("%Area3D")

func _ready():
	# If the material is NOT set to use billboard settings, then avoid running billboard specific code
	if Screen.get_surface_override_material(0).billboard_mode == BaseMaterial3D.BillboardMode.BILLBOARD_DISABLED:
		set_process(false)

func MouseEnteredArea():
	IsMouseInside = true
	# print("Mouse inside")


func MouseExitedArea():
	IsMouseInside = false
	# print("Mouse exited")

func _unhandled_input(event):
	# Check if the event is a non mouse/non touch event
	for mouse_event in [InputEventMouseButton, InputEventMouseMotion, InputEventScreenDrag, InputEventScreenTouch]:
		if is_instance_of(event, mouse_event):
			# If the event is a mouse/touch event, then we can ignore it here, because it will be
			# handled via physics picking
			return
	ViewportNode.push_input(event)

func _mouse_input_event(camera, event, position, normal, shape_idx):
	# Get mesh size to detect edges and make conversions
	var ScreenMeshSize = Screen.mesh.size
	
	# Event position in Area3D in world coordinate space
	var EventPos3D = position
	
	# Current time in seconds since engine start
	var now : float = Time.get_ticks_msec() / 1000.0
	
	# Convert position to a coordinate space relative to the Area3D node
	# NOTE: affine_inverse accounts for the Area3D node's scale, rotation, and position in the scene!
	EventPos3D = Screen.global_transform.affine_inverse() * EventPos3D
	
	var EventPos2D : Vector2 = Vector2()
	
	if IsMouseInside:
		# Convert the relative event position from 3D to 2D
		EventPos2D = Vector2(EventPos3D.x, -EventPos3D.y)
		
		# Right now the event position's range is the following: (-quad_size/2) -> (quad_size/2)
		# We need to convert it into the following range: -0.5 -> 0.5
		EventPos2D.x = EventPos2D.x / ScreenMeshSize.x
		EventPos2D.y = EventPos2D.y / ScreenMeshSize.y
		# Then we need to convert it into the following range: 0 -> 1
		EventPos2D.x += 0.5
		EventPos2D.y += 0.5
		
		# Finally, we convert the position to the following range: 0 -> viewport.size
		EventPos2D.x *= ViewportNode.size.x
		EventPos2D.y *= ViewportNode.size.y
		# We need to do these conversions so the event's position is in the viewport's coordinate system
	elif LastEventPos2D != null:
		# Fall back to the last known event position
		EventPos2D = LastEventPos2D
	
	# Set the events position and global position
	event.position = EventPos2D
	if event is InputEventMouse:
		event.global_position = EventPos2D
	
	# Calculate the relative event distance
	if event is InputEventMouseMotion or event is InputEventScreenDrag:
		# If there is not a stored previous position, then we'll assume there is no relative motion
		if LastEventPos2D == null:
			event.relative = Vector2(0, 0)
		# If there is a stored previous position, then we'll calculate the relative position by subtracting
		# The previous position from the new one. This will give us the distance the event traveled from PrevPos
		else:
			event.relative = EventPos2D - LastEventPos2D
			event.velocity = event.relative / (now - LastEventTime)
	
	# Update LastEventPos2D with the position we just calculated
	LastEventPos2D = EventPos2D
	
	# Update LastEventTime to current time
	LastEventTime = now
	
	# Finally, send the processed input event to the viewport
	ViewportNode.push_input(event)
