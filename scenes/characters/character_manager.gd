extends Node2D

class_name CharacterManager

@export var ui_layer: UILayer
@export var character_list: Array[Character]

@export var action_manager: ActionManager

var character_index: int = 0

func _ready() -> void:
	start()
	ui_layer.populate_characters_label(character_list)

func start() -> void:
	character_index = 0
	for character: Character in character_list:
		character.roll_initiative()
	
	character_list.sort_custom(sort_initiative_desc)
	
	for character: Character in character_list:
		print(character.character_name, ", ", character.initiative)
		
	action_manager.select_action(character_list[character_index])

func sort_initiative_desc(a: Character, b: Character) -> bool:
	if a.initiative < b.initiative:
		return false
	return true


func _on_action_manager_action_selected() -> void:
	character_index += 1
	
	if character_index > character_list.size() - 1:
		character_index = 0
		
	action_manager.select_action(character_list[character_index])
