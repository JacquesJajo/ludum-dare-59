extends Node2D

const baseball_arena: PackedScene = preload("res://scenes/baseball_arena.tscn")
const tough_arena: PackedScene = preload("res://scenes/tougher_arena.tscn")
const boss_arena: PackedScene = preload("res://scenes/boss_arena.tscn")

var level: int = 1

var current_level: Arena

func _ready() -> void:
	if Dialogic.current_timeline != null:
		return
	
	Dialogic.timeline_ended.connect(_on_first_cutscene_finished)
	Dialogic.start("intro")

func _on_first_cutscene_finished() -> void:
	Dialogic.timeline_ended.disconnect(_on_first_cutscene_finished)
	current_level = baseball_arena.instantiate()
	current_level.next_level.connect(_on_baseball_arena_next_level)
	add_child(current_level)

func _on_baseball_arena_next_level() -> void:
	level += 1
	
	current_level.queue_free()
	current_level = tough_arena.instantiate()
	current_level.next_level.connect(_on_tough_arena_next_level)
	add_child(current_level)

func _on_tough_arena_next_level() -> void:
	level += 1
	
	current_level.queue_free()
	current_level = boss_arena.instantiate()
	add_child(current_level)
