extends VBoxContainer

class_name ActionMenu

const action_menu_button: PackedScene = preload("res://scenes/actions/action_menu/action_menu_button.tscn")

@export var options: Array[Action]

signal action_selected(action: Action)

func init_list():
	for action: Action in options:
		var instance: ActionMenuButton = action_menu_button.instantiate()
		instance.text = action.action_name
		instance.action_pressed.connect(_action_button_pressed)
		instance.associated_action = action
		
		add_child(instance)

func _action_button_pressed(action: Action) -> void:
	action_selected.emit(action)
	
	self.queue_free()
