extends VBoxContainer

class_name ActionMenu

const action_menu_button: PackedScene = preload("res://scenes/actions/action_menu/action_menu_button.tscn")

@export var options: Array[Action]

signal action_selected

func init_list():
	for action: Action in options:
		var instance = action_menu_button.instantiate()
		instance.text = action.action_name
		instance.pressed.connect(_action_button_pressed)
		
		add_child(instance)

func _action_button_pressed() -> void:
	action_selected.emit()
	
	self.queue_free()
