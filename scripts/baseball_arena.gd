extends Node2D

class_name Arena

const restart_button: PackedScene = preload("res://scenes/restart.tscn")

@onready var character_manager: CharacterManager = $CharacterManager
@onready var ui_layer: UILayer = $UILayer

signal next_level

var button_instance: Button

func _on_player_defeat() -> void:
	button_instance = restart_button.instantiate()
	ui_layer.get_debug_list().add_child(button_instance)
	button_instance.pressed.connect(_restart_arena)

func _restart_arena() -> void:
	button_instance.queue_free()
	character_manager.reset()
	character_manager.start()


func _on_player_victory() -> void:
	next_level.emit()
