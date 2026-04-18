extends Node2D

class_name CharacterManager

const character_menu: PackedScene = preload("res://scenes/characters/character_menu/character_menu.tscn")

@export var ui_layer: UILayer
@export var character_list: Array[Character]

@export var action_manager: ActionManager

var character_index: int = 0

func _ready() -> void:
	start()

func _process(delta: float) -> void:
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


func _on_action_manager_action_selected(action: Action) -> void:
	action_manager.action_to_execute = action
	action_manager.action_to_execute.user = character_list[character_index]
	
	var target_list: Array[Character]
	target_list.append_array(character_list)
	target_list.remove_at(character_index)
	
	var instance: CharacterMenu = character_menu.instantiate()
	instance.options = target_list
	ui_layer.get_debug_list().add_child(instance)
	instance.init_list()
	instance.character_selected.connect(_on_target_character_selected)
	
func _on_target_character_selected(character: Character) -> void:
	action_manager.action_to_execute.target = character
	action_manager.execute_current()
	
	character_index += 1
	
	if character_index > character_list.size() - 1:
		character_index = 0
		
	action_manager.select_action(character_list[character_index])
