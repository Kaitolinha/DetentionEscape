class_name Room
extends Node

signal ceiling_entered()
signal ceiling_exited()
signal expansion_entered()
signal expansion_exited()

@export var _sides: Node2D
@export var _expansions: Node2D

enum Direction {INITIAL, UP, LEFT, RIGHT, DOWN}

var _is_ceiling: bool = false :
	set(value):
		_is_ceiling = value

		if _is_ceiling:
			_sides.get_child(0).hide()
			_sides.get_child(1).show()
			ceiling_entered.emit()
		else:
			_sides.get_child(0).show()
			_sides.get_child(1).hide()
			ceiling_exited.emit()

var _current_side_index: int = 0 :
	get: return _current_side_index % 4
	set(value):
		var side = _sides.get_child(0).get_child(_current_side_index)
		_sides.get_child(0).get_child(_current_side_index).hide()
		_current_side_index = value
		_sides.get_child(0).get_child(_current_side_index).show()

func _ready() -> void:
	var walls := Node2D.new()

	walls.add_child(preload("res://src/sides/front_side.tscn").instantiate())
	walls.add_child(preload("res://src/sides/right_side.tscn").instantiate())
	walls.add_child(preload("res://src/sides/back_side.tscn").instantiate())
	walls.add_child(preload("res://src/sides/left_side.tscn").instantiate())

	for child in walls.get_children():
		if child is Side:
			child.room = self
			child.hide()

	_sides.add_child(walls)

	var top_side: Side = preload("res://src/sides/top_side.tscn").instantiate()
	top_side.room = self
	top_side.hide()
	_sides.add_child(top_side)

	change(Direction.INITIAL)

func change(direction: Direction) -> void:
	if _expansions.get_child_count() != 0:
		var index: int = _expansions.get_child_count() - 1
		_expansions.get_child(index).queue_free()
		if index == 0:
			_sides.show()
			_expansions.hide()
			expansion_exited.emit()
		return

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

func expand(expansion: Side) -> void:
	_sides.hide()
	_expansions.show()
	_expansions.add_child(expansion)
	expansion_entered.emit()
