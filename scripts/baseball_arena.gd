extends Node2D

class_name Arena

@onready var character_manager: CharacterManager = $CharacterManager

signal next_level

func _on_player_defeat() -> void:
	character_manager.reset()
	character_manager.start()


func _on_player_victory() -> void:
	next_level.emit()
