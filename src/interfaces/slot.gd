class_name Slot
extends Control

@export var _image: TextureRect
@export var _button: Button
@export var _background: Panel

var interface: Interface

func _ready() -> void:
	_button.pressed.connect(func() -> void:
		if Global.game.inventory.is_focus():
			Global.game.inventory.swap(get_index())
		else:
			var item: Item = Global.game.inventory.get_item(get_index())
			if is_instance_valid(item):
				Global.game.inventory.focus(get_index()))

func focus(enable: bool) -> void:
	_background.modulate.a = 0.5 if enable else 0.25
	_image.modulate = Color.BLACK if enable else Color.WHITE

func refresh() -> void:
	var item: Item = Global.game.inventory.get_item(get_index())
	_image.texture = item.texture if is_instance_valid(item) else null
