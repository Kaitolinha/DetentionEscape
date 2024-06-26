extends State

@export var _animation: AnimationPlayer

func change(to: State) -> void:
	_animation.play("down")
	await _animation.animation_finished
	super.change(to)
