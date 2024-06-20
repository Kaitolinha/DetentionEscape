extends Button

@export var message: String

func _ready() -> void:
	pressed.connect(func() -> void:
		for child in get_children():
			if child is Interact:
				child.interact()
		Global.game.message.send(Message.MessageType.INFO, message))
