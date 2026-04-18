extends Action

class_name ThrowAttack

func do_action() -> void:
	# TODO: hit roll based on throw stats
	target.take_damage(user.strength)
