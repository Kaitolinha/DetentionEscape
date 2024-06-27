class_name AnimationState
extends State

@export var animator: AnimationPlayer
@export var enter_animation: String
@export var exit_animation: String

func enter() -> void:
	animator.play(enter_animation)
	await animator.animation_finished
	super.enter()

func exit() -> void:
	super.exit()
	animator.play(exit_animation)
	await animator.animation_finished
