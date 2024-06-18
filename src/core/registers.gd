extends Node

var _data: Dictionary

func register(item: Item) -> void:
	_data[item.get_instance_id()] = true

func contains(item: Item) -> bool:
	return _data.has(item.get_instance_id())
