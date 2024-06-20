extends Control

@export var _start_button: Button

func _ready() -> void:
	_start_button.pressed.connect(func() -> void:
		get_tree().change_scene_to_file("res://src/room.tscn"))
