extends Node2D

class_name Action

const CRITICAL: int = 20

@export var action_name: String

var user: Character
var target: Character

var critical: bool = false

signal action_complete

func do_action() -> void:
	pass

func _receive_signal() -> void:
	pass
