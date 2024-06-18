class_name InteractItem
extends Interact

@export var item: Item

func _ready() -> void:
	if Registers.contains(item):
		queue_free()

func interact() -> void:
	if Inventory.insert(item):
		Message.send(Message.MessageType.SLOT, item.title)
		Registers.register(item)
		queue_free()
