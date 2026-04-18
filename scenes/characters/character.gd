extends Node2D

class_name Character

const MAX_INITIATIVE: int = 100

@export var character_name: String

@export var initiative_bonus: int
@export var strength: int
@export var max_magic: int
@export var max_health: int

@export var is_pitcher: bool

var initiative: int

var health: int
var magic: int

func _ready() -> void:
	reset()

func reset():
	health = max_health
	magic = max_magic

func roll_initiative():
	if is_pitcher:
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
