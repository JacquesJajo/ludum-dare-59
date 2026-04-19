extends Action

class_name SwingAttack

const SWING_SPEED: float = 512.0
var speed_modifier: float = 1.0

var saved_baseball: Baseball

var buff_level: int

var active_processing: bool = false

func do_action() -> void:
	buff_level = 0
	var message: Array[String] = []
	for ally: Character in user.ally_buffs:
		if ally.signal_to_wait_for == action_name:
			message.append(ally.character_name + " buffed your attack!")
			buff_level += 1
		ally.signal_to_wait_for = ""
	if message.size() <= 0:
		message.append("No buff signals received!")
	show_message(message)
	Dialogic.timeline_ended.connect(_message_shown)
	
func _message_shown() -> void:
	Dialogic.timeline_ended.disconnect(_message_shown)
	dialogue_timer.stop()
	
	# TODO: play ally buff animations, connect to signal
	# and apply buffs then play user animations
	user.ally_buffs.clear()
	
	user.gfx.play("swing")
	user.gfx.animation_finished.connect(_swing_finished)

func _swing_finished() -> void:
	user.gfx.animation_finished.disconnect(_swing_finished)
	user.gfx.play("default")
	
	saved_baseball = user.baseball_list.pop_front()
	user.clear_baseball_list()
	
	modify_baseball()
	saved_baseball.move_complete.connect(_baseball_swung_back)
	saved_baseball.move_sprite(target.gfx.global_position, SWING_SPEED * speed_modifier)

func modify_baseball() -> void:
	pass

func _baseball_swung_back() -> void:
	saved_baseball.move_complete.disconnect(_baseball_swung_back)
	saved_baseball.queue_free()
	
	var roll: int = randi_range(1, 20) + user.swing_bonus
	if roll >= target.armour_class:
		# TODO: more complex damage / to hit
		target.take_damage(user.strength)
	if roll >= CRITICAL:
		critical = true
	
	user.gfx.move_complete.connect(_base_moved)
	user.gfx.move_sprite(user.base_manager.bases[user.base_index + 1], 128.0)
	affect_bases.emit(user)

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
		affect_bases.emit(user)
