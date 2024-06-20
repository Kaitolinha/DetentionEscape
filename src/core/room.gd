class_name Room
extends Node

signal ceiling_entered()
signal ceiling_exited()

enum Direction {INITIAL, UP, LEFT, RIGHT, DOWN}

var _is_ceiling: bool = false :
	set(value):
		_is_ceiling = value

		if _is_ceiling:
			get_child(0).hide()
			get_child(1).show()
			ceiling_entered.emit()
		else:
			get_child(0).show()
			get_child(1).hide()
			ceiling_exited.emit()

var _current_side_index: int = 0 :
	get: return _current_side_index % 4
	set(value):
		get_child(0).get_child(_current_side_index).hide()
		_current_side_index = value
		get_child(0).get_child(_current_side_index).show()

func _ready() -> void:
	var sides := Node2D.new()

	sides.add_child(preload("res://src/sides/front_side.tscn").instantiate())
	sides.add_child(preload("res://src/sides/right_side.tscn").instantiate())
	sides.add_child(preload("res://src/sides/back_side.tscn").instantiate())
	sides.add_child(preload("res://src/sides/left_side.tscn").instantiate())

	for child in sides.get_children():
		if child is Side:
			child.room = self
			child.hide()

	add_child(sides)

	var top_side: Side = preload("res://src/sides/top_side.tscn").instantiate()
	top_side.room = self
	top_side.hide()
	add_child(top_side)

	change(Direction.INITIAL)

func change(direction: Direction) -> void:
	match direction:
		Direction.INITIAL:
			_current_side_index = 0
		Direction.LEFT:
			if _is_ceiling: _is_ceiling = false
			_current_side_index -= 1
		Direction.RIGHT:
			if _is_ceiling: _is_ceiling = false
			_current_side_index += 1
		Direction.UP:
			if _is_ceiling: _current_side_index += 2
			_is_ceiling = !_is_ceiling
		Direction.DOWN:
			if _is_ceiling: _is_ceiling = false
