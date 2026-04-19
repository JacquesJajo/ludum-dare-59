extends Action

class_name AwaitSignal

func do_action() -> void:
	user.ally_to_buff.ally_buffs.append(user)
	action_complete.emit()
