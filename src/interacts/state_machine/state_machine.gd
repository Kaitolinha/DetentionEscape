## State machine for managing States.
class_name StateMachine
extends Node

signal changed(from: State, to: State)

## State for the StateMachine to start in.
@export var initial_state : State
@export var delete_when_finished: bool

var current_state : State

func _ready() -> void:
	if initial_state:
		current_state = initial_state
	elif get_child_count() > 0:
		current_state = get_child(0)
	else: return
	
	for state : Node in get_children():
		state.Transitioned.connect(on_state_transitioned)
	
	current_state.enter()
	current_state.active = true

func _physics_process(delta: float) -> void:
	if is_instance_valid(current_state):
		current_state.update(delta)

func on_state_transitioned(state : State, new_state : State) -> void:
	if state != current_state: return
	if !current_state: return
	
	if !is_instance_valid(new_state):
		current_state.exit()
		current_state.active = false
		changed.emit(current_state, null)
		current_state = null
		if delete_when_finished:
			get_parent().queue_free()
		return

	if new_state == current_state: return

	current_state.exit()
	current_state.active = false

	new_state.enter()
	new_state.active = true
	changed.emit(current_state, new_state)
	current_state = new_state
