class_name StateMachine
extends Node2D

signal changed(state: State)

@export var _initial_state: State

var current_state: State

func _ready() -> void:
	change(_initial_state)

func change(state: State) -> void:
	if is_instance_valid(current_state):
		current_state.exit()
		current_state.exited.emit()
	current_state = state
	current_state.enter()
	current_state.entered.emit()

	print("%s State changed to %s" % [name, state.name])
