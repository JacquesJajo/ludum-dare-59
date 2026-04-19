extends Node2D

class_name Titlescreen

signal start_game

func _on_button_pressed() -> void:
	start_game.emit()
