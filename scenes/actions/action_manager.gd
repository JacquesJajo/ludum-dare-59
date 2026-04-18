extends Node2D

class_name ActionManager

const action_menu: PackedScene = preload("res://scenes/actions/action_menu/action_menu.tscn")

signal action_selected

@export var ui_layer: UILayer

func select_action(character: Character) -> void:
	var instance = action_menu.instantiate()
	instance.options = character.get_possible_actions()
	ui_layer.get_debug_list().add_child(instance)
	instance.init_list()
	instance.action_selected.connect(_on_menu_action_selected)

func _on_menu_action_selected():
	action_selected.emit()
