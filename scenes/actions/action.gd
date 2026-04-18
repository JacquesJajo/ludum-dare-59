extends Node2D

class_name Action

@export var action_name: String

var user: Character
var target: Character

func do_action() -> void:
	pass

func _receive_signal() -> void:
	pass
