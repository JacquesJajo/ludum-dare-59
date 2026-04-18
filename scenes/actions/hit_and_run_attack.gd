extends Action

class_name HitAndRunAttack

func do_action() -> void:
	# TODO: hit roll based on speed stats + AOE effect
	target.take_damage(user.strength)
