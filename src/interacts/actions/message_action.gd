class_name MessageAction
extends Action

@export var message: String

func act() -> bool:
	Global.game.message.send(Message.MessageIn.LEFT, message)
	return false
