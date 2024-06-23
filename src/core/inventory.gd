class_name Inventory
extends Node

signal inserted(index: int)
signal removed(index: int)
signal refreshed(index: int)
signal focused(index: int, enable: bool)

@export var minimum: int = 5
var index_focused: int = -1
var _data: Array[Item]

func _ready() -> void:
	_data.resize(minimum)
	_data.fill(null)

func insert(item: Item) -> void:
	for index in _data.size():
		if _data[index] == null:
			_data[index] = item
			refreshed.emit(index)
			inserted.emit(index)
			return

	_data.push_back(item)
	inserted.emit(size() - 1)
	refreshed.emit(size() - 1)

func request(item: Item) -> bool:
	if _can_index(index_focused) and _data[index_focused] == item:
		if size() > minimum:
			_data.pop_back()
			removed.emit(index_focused)
		else:
			_data[index_focused] = null
			refreshed.emit(index_focused)
		reset()
		return true

	reset()
	return false

func swap(index: int) -> void:
	if _can_index(index_focused) and _can_index(index):
		if index_focused != index:
			var temp: Item = _data[index_focused]
			_data[index_focused] = _data[index]
			_data[index] = temp
			refreshed.emit(index_focused)
			refreshed.emit(index)
		reset()

func reset() -> void:
		focused.emit(index_focused, false)
		index_focused = -1

func focus(index: int) -> void:
	if _can_index(index):
		focused.emit(index_focused, false)
		index_focused = index
		focused.emit(index_focused, true)

func is_focus() -> bool:
	return index_focused > -1

func size() -> int:
	return _data.size()

func get_item(index: int) -> Item:
	return _data[index] if _can_index(index) else null

func _can_index(index: int) -> bool:
	return index > -1 and index < _data.size()
