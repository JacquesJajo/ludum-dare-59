extends Action

class_name SwingAttack

func do_action() -> void:
	# TODO: hit roll based on swing stats
	target.take_damage(user.strength)
	
	user.gfx.move_complete.connect(_base_moved)
	user.gfx.move_sprite(user.base_manager.bases[user.base_index + 1], 128.0)

func _base_moved() -> void:
	user.gfx.move_complete.disconnect(_base_moved)
	user.base_index += 1
	if user.base_index >= user.base_manager.bases.size() - 1:
		user.base_index = -1
	action_complete.emit()
