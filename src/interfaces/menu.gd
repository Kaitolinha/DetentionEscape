extends Control

@export var _game_scene: PackedScene
@export var _start_button: Button

func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("enter")
	await $AnimationPlayer.animation_finished
	$Transition.queue_free()
	_start_button.pressed.connect(func() -> void:
		get_tree().change_scene_to_packed(_game_scene))
