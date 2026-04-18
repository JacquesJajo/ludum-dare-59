extends Action

class_name SwingAttack

func do_action() -> void:
	# TODO: hit roll based on swing stats
	target.take_damage(user.strength)
