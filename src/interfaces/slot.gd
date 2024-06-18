class_name Slot
extends Control

@export var _background: ColorRect
@export var _image: TextureRect
@export var _button: Button

var interface: Interface
var index: int = -1

func _ready() -> void:
	if !is_instance_valid(interface): return

	_button.pressed.connect(func() -> void:
		if is_instance_valid(interface.slot_focus):
			Inventory.swap(interface.slot_focus.index, index)
			interface.slot_focus.focus(false)
			interface.slot_focus = null
		else:
			var item: Item = Inventory.get_item(index)
			if is_instance_valid(item):
				Message.send(Message.MessageType.SLOT, item.title)
				interface.slot_focus = self
				focus(true))

func focus(enable: bool) -> void:
	_background.color.a = 0.1 if enable else 0.25

func refresh() -> void:
	var item: Item = Inventory.get_item(index)
	_image.texture = item.texture if is_instance_valid(item) else null
