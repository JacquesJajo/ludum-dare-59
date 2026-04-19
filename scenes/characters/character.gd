extends Node2D

class_name Character

const MAX_INITIATIVE: int = 100

enum State { # I don't know anything about baseball
	FIELDER,
	BATTER,
	PITCHER,
	ON_BASE
}

@export var character_name: String

@export var initiative_bonus: int
@export var strength: int
@export var max_magic: int
@export var max_health: int

@export var swing_bonus: int
@export var armour_class: int

@export var initial_base_index: int

@export var state: State

@export var gfx: CharacterSprite

@export var is_npc: bool

var base_manager: BaseManager
var base_index: int = -1

var initiative: int

var health: int
var magic: int

@export var ally_to_buff: Character
var ally_buffs: Array[Character]

func _ready() -> void:
	reset()

func reset():
	health = max_health
	magic = max_magic
	base_index = initial_base_index

func roll_initiative():
	if state == State.PITCHER:
		initiative = MAX_INITIATIVE
		return
		
	initiative = randi_range(1, 20) + initiative_bonus
	
func take_damage(damage: int):
	health -= damage

func get_possible_actions() -> Array[Action]:
	var actions: Array[Action] = []
	for child in get_children():
		if child is Action:
			actions.append(child)
			
	return actions

func get_random_option() -> Action:
	return get_possible_actions()[randi_range(0, get_possible_actions().size() - 1)]

func is_pitcher() -> bool:
	return state == State.PITCHER
	
func is_batter() -> bool:
	return state == State.BATTER

func is_on_base() -> bool:
	return state == State.ON_BASE
	
func is_fielder() -> bool:
	return state == State.FIELDER
