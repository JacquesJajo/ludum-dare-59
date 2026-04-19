extends Action

class_name ThrowAttack

const baseball: PackedScene = preload("res://scenes/baseball.tscn")

const THROW_SPEED: float = 256.0

var baseball_instance: Baseball

func do_action() -> void:
	user.gfx.play("attack")
	user.gfx.animation_finished.connect(_on_attack_animation_finished)

func _on_attack_animation_finished() -> void:
	user.gfx.animation_finished.disconnect(_on_attack_animation_finished)
	user.gfx.play("default")
	
	baseball_instance = baseball.instantiate()
	user.gfx.add_child(baseball_instance)
	baseball_instance.move_complete.connect(_baseball_at_target)
	baseball_instance.move_sprite(target.gfx.global_position, THROW_SPEED)

func _baseball_at_target() -> void:
	baseball_instance.move_complete.disconnect(_baseball_at_target)
	if !target.is_batter():
		baseball_instance.queue_free()
	else:
		baseball_instance.global_position = target.gfx.get_hold_spot()
		target.baseball_list.append(baseball_instance)
	
	# TODO: hit roll based on throw stats
	target.take_damage(user.strength)
	
	action_complete.emit()
