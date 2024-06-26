## State machine for managing States.
extends Node
class_name StateMachine

## State for the StateMachine to start in.
@export var initial_state : State

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

func _process(_delta : float) -> void:
	if current_state:
		current_state.update()

func _physics_process(_delta : float) -> void:
	if current_state:
		current_state.physics_update()

func on_state_transitioned(state : State, new_state : State) -> void:
	if state != current_state:
		printerr("Cannot change state from a non-active state")
		return
	
	if !current_state:
		printerr("Current state is null, cannot transition")
		return
	
	if !is_instance_valid(new_state):
		print("Received null state, stopping the state machine.")
		current_state.exit()
		current_state.active = false
		current_state = null
		return

	if new_state == current_state:
		print("State is already in the desired state, no transition occurs.")
		return
	
	current_state.exit()
	current_state.active = false

	new_state.enter()
	new_state.active = true
	current_state = new_state
