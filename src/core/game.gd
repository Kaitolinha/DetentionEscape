class_name Game
extends Node2D

signal fan_turned_on()
var has_energy: bool = false
signal game_complete()

@export var message: Message
@export var inventory: Inventory

func _init() -> void:
	Global.game = self
