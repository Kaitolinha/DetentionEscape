class_name DeleteAction
extends Action

@export var _state_machine: StateMachine

func act() -> bool:
	_state_machine.queue_free()
	return true
