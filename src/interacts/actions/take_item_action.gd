class_name TakeItemAction
extends ItemAction

@export var _not_has_item: String
@export var _has_item: String

func act() -> bool:
	var result: bool = Global.game.inventory.request(item)
	Global.game.message.send(Message.MessageIn.LEFT, _has_item if result else _not_has_item)
	return result
