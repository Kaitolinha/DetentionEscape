class_name GiveItemAction
extends ItemAction

@export var message: String 

func act() -> bool:
	Global.game.inventory.insert(item)
	Global.game.message.send(Message.MessageIn.LEFT, message)
	return true
