extends Button

class_name CharacterMenuButton

var associated_character: Character

signal character_pressed(character: Character)

func _on_pressed() -> void:
	character_pressed.emit(associated_character)
