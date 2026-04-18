extends Action

class_name SwingAttack

func do_action() -> void:
	var roll: int = randi_range(1, 20) + user.swing_bonus
	print(roll)
	if roll >= target.armour_class:
		# TODO: hit roll based on swing stats
		target.take_damage(user.strength)
	if roll >= CRITICAL:
		print("critical!")
		critical = true
	
	user.gfx.move_complete.connect(_base_moved)
	user.gfx.move_sprite(user.base_manager.bases[user.base_index + 1], 128.0)

func _base_moved() -> void:
	user.base_index += 1
	if user.base_index >= user.base_manager.bases.size() - 1:
		user.base_index = -1
		
	if !critical:
		action_complete.emit()
		user.gfx.move_complete.disconnect(_base_moved)
		
	else:
		critical = false
		user.gfx.call_deferred("move_sprite", user.base_manager.bases[user.base_index + 1], 128.0)
