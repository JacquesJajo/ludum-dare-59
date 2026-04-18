extends Button

class_name ActionMenuButton

var associated_action: Action

signal action_pressed(action: Action)

func _on_pressed() -> void:
	action_pressed.emit(associated_action)
