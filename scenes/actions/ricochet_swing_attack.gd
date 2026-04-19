extends SwingAttack

func modify_baseball() -> void:
	pass

func _baseball_swung_back() -> void:
	saved_baseball.move_complete.disconnect(_baseball_swung_back)
	var new_targets: Array[Character] = user.character_manager.get_npc_list()
	if buff_level > 0 and new_targets.size() > 1:
		buff_level -= 1
		
		target.take_damage(user.strength)
		
		new_targets.remove_at(new_targets.find(target))
		target = new_targets[randi_range(0, new_targets.size() - 1)]
		
		saved_baseball.move_complete.connect(_baseball_swung_back)
		saved_baseball.call_deferred("move_sprite", target.gfx.global_position, SWING_SPEED)
		
	else:
		saved_baseball.queue_free()
		
		var roll: int = randi_range(1, 20) + user.swing_bonus

		target.take_damage(user.strength)
		if roll >= CRITICAL:
			critical = true
		
		user.gfx.move_complete.connect(_base_moved)
		user.gfx.move_sprite(user.base_manager.bases[user.base_index + 1], 128.0)
		
		affect_bases.emit(user)
