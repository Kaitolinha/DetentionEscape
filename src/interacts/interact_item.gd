class_name InteractItem
extends Interact

@export var item: Item

func interact() -> void:
	if Global.game.inventory.insert(item):
		Global.game.message.send(Message.MessageType.SLOT, item.title)
		queue_free()
