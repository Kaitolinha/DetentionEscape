extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	var animator = $AnimationPlayer as AnimationPlayer
	animator.play("enter")
	await animator.animation_finished
	await get_tree().create_timer(3).timeout
	animator.play("exit")
	await animator.animation_finished
	get_tree().change_scene_to_file("res://src/interfaces/menu.tscn")
