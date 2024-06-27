extends ColorRect

@export var animator: AnimationPlayer
@export var enter_animation: String
@export var exit_animation: String
@export var state: State

func _ready() -> void:
	state.get_parent().changed.connect(func(from: State, to: State) -> void:
		if from == state:
			animator.play(exit_animation)
		if to == state:
			animator.play(enter_animation)
	)
