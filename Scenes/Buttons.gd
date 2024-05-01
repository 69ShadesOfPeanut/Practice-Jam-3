# Controls buttons
extends HBoxContainer

# Vars
var GoodScore : int
var BadScore : int
# Nodes
@onready var ScreenNode : Control = get_node("%Screen")
@onready var ScreenText : Label = ScreenNode.get_node("%Text")


# gets button presses
func ButtonPress(Result):
	print(Result)
