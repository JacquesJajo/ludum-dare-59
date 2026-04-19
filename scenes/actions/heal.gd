extends Action

func do_action() -> void:
	target.health += user.heal
	if target.health > target.max_health:
		target.health = target.max_health

	action_complete.emit()
