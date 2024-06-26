class_name TakeItemAction
extends ItemAction

@export var message_if_has_item: String
@export var message_if_not_has_item: String

func act() -> bool:
	var result: bool = Global.game.inventory.request(item)
	Global.game.message.send(Message.MessageIn.LEFT,
		message_if_has_item if result else message_if_not_has_item)
	return result
