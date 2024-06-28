extends Action

func act() -> bool:
	if Global.game.has_energy:
		return true

	Global.game.message.send(Message.MessageIn.LEFT, "Não tem energia.")
	return false
