class_name Message
extends Node

signal info_sent(message: StringName)
signal slot_sent(message: StringName)

enum MessageIn {LEFT, RIGHT}

func send(localization: MessageIn, message: StringName) -> void:
	if message.is_empty(): return

	match localization:
		MessageIn.LEFT:
			info_sent.emit(message)
		MessageIn.RIGHT:
			slot_sent.emit(message)
