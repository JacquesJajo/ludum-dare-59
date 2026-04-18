extends VBoxContainer

class_name CharacterMenu

const character_menu_button: PackedScene = preload("res://scenes/characters/character_menu/character_menu_button.tscn")

@export var options: Array[Character]

signal character_selected(character: Character)

func init_list():
	for character: Character in options:
		var instance: CharacterMenuButton = character_menu_button.instantiate()
		instance.text = character.character_name
		instance.character_pressed.connect(_character_button_pressed)
		instance.associated_character = character
		
		add_child(instance)

func _character_button_pressed(character: Character) -> void:
	character_selected.emit(character)
	
	self.queue_free()
