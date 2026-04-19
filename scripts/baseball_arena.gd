extends Node2D

@onready var character_manager: CharacterManager = $CharacterManager

func _on_player_defeat() -> void:
	character_manager.reset()
	character_manager.start()


func _on_player_victory() -> void:
	pass # Replace with function body.
