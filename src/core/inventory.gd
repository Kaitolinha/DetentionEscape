class_name Inventory
extends Node

signal refreshed(index: int)

@export var capacity: int = 5
var _data: Array[Item]

func _ready() -> void:
	_data.resize(capacity)
	_data.fill(null)

func insert(item: Item) -> bool:
	for index in range(capacity):
		if _data[index] == null:
			_data[index] = item
			refreshed.emit(index)
			return true
	return false

func request(item: Item) -> bool:
	for index in range(capacity):
		if _data[index] == item:
			_data[index] = null
			refreshed.emit(index)
			return true
	return false

func swap(from: int, to: int) -> void:
	if _can_index(from) and _can_index(to):
		var temp: Item = _data[from]
		_data[from] = _data[to]
		_data[to] = temp
		refreshed.emit(from)
		refreshed.emit(to)

func get_item(index: int) -> Item:
	return _data[index] if _can_index(index) else null

func _can_index(index: int) -> bool:
	return index > -1 and index < _data.size()
