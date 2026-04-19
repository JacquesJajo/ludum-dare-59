extends Action

class_name ThrowAttack

func do_action() -> void:
	user.gfx.play("attack")
	user.gfx.animation_finished.connect(_on_attack_animation_finished)

func _on_attack_animation_finished() -> void:
	user.gfx.animation_finished.disconnect(_on_attack_animation_finished)
	user.gfx.play("default")
	# TODO: hit roll based on throw stats
	target.take_damage(user.strength)
	
	action_complete.emit()
