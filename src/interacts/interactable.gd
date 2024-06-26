class_name Interactable
extends Button
 
@export var _at_state: State
@export var _to_state: State
@export var _auto_delete: bool

func _ready() -> void:
	if is_instance_valid(_to_state):
		_to_state.entered.connect(func() -> void:
			if _auto_delete: queue_free() else: hide())

	if is_instance_valid(_at_state):
		hide()
		_at_state.entered.connect(func() -> void:
			show())

	pressed.connect(func() -> void:
		for child in get_children():
			if child is Action:
				if !child.act(): return

		if is_instance_valid(_at_state) and is_instance_valid(_to_state):
			_at_state.change(_to_state))
