extends Node2D

class_name CharacterManager

const character_menu: PackedScene = preload("res://scenes/characters/character_menu/character_menu.tscn")

@export var ui_layer: UILayer
@export var character_list: Array[Character]

@export var action_manager: ActionManager
@export var gfx_manager: GFXManager

@export var base_manager: BaseManager
@export var pitcher_plate: Node2D

var character_index: int = 0

func _ready() -> void:
	start()

func _process(delta: float) -> void:
	ui_layer.populate_characters_label(character_list)

func start() -> void:
	character_index = 0
	base_manager.build_list()
	
	for character: Character in character_list:
		if character.is_pitcher():
			character.gfx.position = pitcher_plate.position
		elif character.is_batter():
			character.gfx.position = base_manager.bases[3]
		elif character.is_on_base():
			character.gfx.position = base_manager.bases[character.initial_base_index]
		elif character.is_fielder():
			character.gfx.position = Vector2(randi_range(-128, 128), randi_range(-32, 32))
		character.base_manager = base_manager
		
		character.roll_initiative()
	
	character_list.sort_custom(sort_initiative_desc)
		
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
	action_manager.action_to_execute.action_complete.connect(_action_completed)
	action_manager.execute_current()

func _action_completed() -> void:
	action_manager.action_to_execute.action_complete.disconnect(_action_completed)
	character_index += 1
	
	if character_index > character_list.size() - 1:
		character_index = 0
		
	action_manager.select_action(character_list[character_index])
	
func _run_those_on_base(user: Character) -> void:
	for character: Character in character_list:
		if character != user and character.is_on_base():
			character.gfx.move_sprite(character.base_manager.bases[character.base_index + 1], 128.0)
			character.base_index += 1
			if character.base_index >= character.base_manager.bases.size() - 1:
				character.base_index = -1
