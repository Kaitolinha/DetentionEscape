class_name Game
extends Node2D

@export var message: Message
@export var inventory: Inventory

func _init() -> void:
	Global.game = self
