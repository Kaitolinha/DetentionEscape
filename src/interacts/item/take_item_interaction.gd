class_name TakeItemInteraction
extends ItemInteraction

@export var message_if_has_item: String
@export var message_if_not_has_item: String

func interact() -> void:
	Global.game.message.send(Message.MessageIn.LEFT,
		message_if_has_item if Global.game.inventory.request(item) else message_if_not_has_item)
