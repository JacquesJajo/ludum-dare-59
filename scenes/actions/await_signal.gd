extends Action

class_name AwaitSignal

const action_menu: PackedScene = preload("res://scenes/actions/action_menu/action_menu.tscn")

@export var ui_layer: UILayer

func do_action() -> void:
	var instance: ActionMenu = action_menu.instantiate()
	instance.options = user.ally_to_buff.get_possible_actions()
	ui_layer.get_debug_list().add_child(instance)
	instance.init_list()
	instance.action_selected.connect(_on_menu_action_selected)

func _on_menu_action_selected(action: Action) -> void:
	user.ally_to_buff.ally_buffs.append(user)
	user.signal_to_wait_for = action.action_name
	show_message([user.character_name + ": " + "I'll wait for your signal!"])
	Dialogic.timeline_ended.connect(_message_shown)
	
func _message_shown() -> void:
	Dialogic.timeline_ended.disconnect(_message_shown)
	dialogue_timer.stop()
	action_complete.emit()
