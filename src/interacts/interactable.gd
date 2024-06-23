extends Button

@export var message: String

func _ready() -> void:
	pressed.connect(func() -> void:
		Global.game.message.send(Message.MessageIn.LEFT, message)
		for child in get_children():
			if child is Interaction:
				child.interact())
