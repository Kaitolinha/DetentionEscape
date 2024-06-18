extends Node

var side_spawn: Node
var _current_side_index: int = 0

func start(spawn: Node) -> void:
	side_spawn = spawn

	side_spawn.add_child(preload("res://src/sides/side_front.tscn").instantiate())
	side_spawn.add_child(preload("res://src/sides/side_right.tscn").instantiate())
	side_spawn.add_child(preload("res://src/sides/side_back.tscn").instantiate())
	side_spawn.add_child(preload("res://src/sides/side_left.tscn").instantiate())

	for side in side_spawn.get_children():
		side.hide()

	_change_side(0)


func next_side() -> void:
	_change_side(_current_side_index + 1 if _current_side_index < 3 else 0)

func previous_side() -> void:
	_change_side(_current_side_index - 1 if _current_side_index > 0 else 3)

func _change_side(new_side_index: int) -> void:
	if !is_instance_valid(side_spawn): return

	side_spawn.get_child(_current_side_index).hide()
	_current_side_index = new_side_index
	side_spawn.get_child(_current_side_index).show()
