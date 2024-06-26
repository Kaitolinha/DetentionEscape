class_name State
extends Node

signal entered()
signal exited()

func enter() -> void: pass
func exit() -> void: pass

func change(to: State) -> void:
	get_parent().change(to)
