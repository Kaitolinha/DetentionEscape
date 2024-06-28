extends Side

func _ready() -> void:
	Global.game.fan_turned_on.connect(func() -> void:
		$Fan/StateMachine.current_state.Transitioned.emit(
			$Fan/StateMachine.current_state, $Fan/StateMachine/OnState))
