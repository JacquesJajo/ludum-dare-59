extends SwingAttack

const explosion: PackedScene = preload("res://scenes/explosion.tscn")

const EXPLOSION_DAMAGE_MOD: int = 2

var potential_hits: Array[Character]

var explosion_instance: Explosion

func modify_baseball() -> void:
	potential_hits = user.character_manager.get_npc_list()
	
	explosion_instance = explosion.instantiate()
	explosion_instance.max_radius = buff_level + 1.0
	
	saved_baseball.add_child(explosion_instance)
	
	speed_modifier = 0.25

	active_processing = true
	
func _process(delta: float) -> void:
	if !active_processing:
		return
		
	for npc: Character in potential_hits:
		if explosion_instance.global_position.distance_to(npc.gfx.global_position) < explosion_instance.get_pixel_radius():
			npc.take_damage(user.strength * EXPLOSION_DAMAGE_MOD)
			potential_hits.remove_at(potential_hits.find(npc))

func _baseball_swung_back() -> void:
	saved_baseball.move_complete.disconnect(_baseball_swung_back)
	saved_baseball.queue_free()
	
	user.gfx.move_complete.connect(_base_moved)
	user.gfx.move_sprite(user.base_manager.bases[user.base_index + 1], 128.0)
	affect_bases.emit(user)
	
	active_processing = false
