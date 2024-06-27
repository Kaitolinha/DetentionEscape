extends Node2D

var label: Label

func _ready() -> void:
	label = Label.new()
	label.text = $StateMachine.current_state.name
	label.position.y = -40
	$Image.add_child(label)

	$StateMachine.changed.connect(func(from: State, to: State) -> void:
		label.text = to.name if to else "Done.")
