class_name Message
extends Node

signal info_sent(message: StringName)
signal slot_sent(message: StringName)

enum MessageType {INFO, SLOT}

func send(type: MessageType, message: StringName) -> void:
	match type:
		MessageType.INFO:
			info_sent.emit(message)
		MessageType.SLOT:
			slot_sent.emit(message)
