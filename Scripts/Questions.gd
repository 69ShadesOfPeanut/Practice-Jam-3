# Script for handling question app.
# Gives random answers to questions unless its a specific coded question
extends WindowNode

# Vars
@export var DefaultAnswers : Array[String]
@export var ScriptedQuestions : Dictionary
# Nodes
@onready var QuestionEnterNode : LineEdit = get_node("%QuestionEnter")
@onready var CurrentScene : Control = get_tree().current_scene
@onready var OpenApps : Control = CurrentScene.get_node("%OpenApps")
# Resources
const AnswerScene = preload("res://Scenes/ComputerApps/Answer.tscn")


# Called when players submit a question
func QuestionSubmitted(text : String):
	# Return if question is empty
	if text.strip_edges(true, true).is_empty():
		print("Question is empty")
		QuestionEnterNode.clear()
		return
	
	# Make an instance of the answer scene and set properties
	var AnswerSceneInstance = AnswerScene.instantiate()
	AnswerSceneInstance.set_position(Vector2(300, 300))
	AnswerSceneInstance.set_title("Answer to: " + text)
	
	
	
	# Goes through scripted questions and sees if question asked matches
	# if it matches, display the dictionary value / result.
	var Question = text.rstrip("?").to_lower()
	var IsScriptedQuestion = false
	for key in ScriptedQuestions:
		if Question == key.to_lower():
			AnswerSceneInstance.get_node("AnswerLabel").set_text(ScriptedQuestions[key])
			IsScriptedQuestion = true
		elif IsScriptedQuestion == false:
			AnswerSceneInstance.get_node("AnswerLabel").set_text(DefaultAnswers.pick_random())
	
	# Clear text enter and add instance to scene
	QuestionEnterNode.clear()
	OpenApps.add_child(AnswerSceneInstance)
