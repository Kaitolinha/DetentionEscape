class_name GiveItemInteraction
extends ItemInteraction

@export var message: String 

func interact() -> void:
	Global.game.inventory.insert(item)
	Global.game.message.send(Message.MessageIn.LEFT, message)
