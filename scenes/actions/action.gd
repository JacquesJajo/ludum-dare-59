extends Node2D

class_name Action

const CRITICAL: int = 20

@export var action_name: String
@onready var dialogue_timer: Timer = $DialogueTimer

var user: Character
var target: Character

var critical: bool = false

signal action_complete
signal affect_bases(user: Character)

func do_action() -> void:
	pass

func _receive_signal() -> void:
	pass

func show_message(message: Array[String]) -> void:
	if Dialogic.current_timeline != null:
		return
	
	var events: Array[String] = message
	var timeline: DialogicTimeline = DialogicTimeline.new()
	timeline.events = events
	Dialogic.start(timeline)
	
	dialogue_timer.start()


func _on_dialogue_timer_timeout() -> void:
	Dialogic.end_timeline(true)
