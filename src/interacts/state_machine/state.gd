class_name State
extends Node

@export var _next: State
@export var _interactable: Interactable
var _interactables: Array[Interactable]

signal Transitioned
var active := false

func _ready() -> void:
	if is_instance_valid(_interactable):
		_interactables.append(_interactable)

	for interactable in _interactables:
		interactable.hide()

func change(state: State, interactable: Interactable) -> void:
	for child in interactable.get_children():
		if child is Action:
			if child.act():
				var pause: bool = child.pause
				if child.delete: child.queue_free()
				Transitioned.emit(self, state) 
				if pause: return
			else: return

	if interactable.delete:
		interactable.queue_free()
		_interactables.erase(interactable)

func enter() -> void:
	if is_instance_valid(_interactable):
		_interactable.pressed.connect(_on_change)

	for interactable in _interactables:
		interactable.show()

func exit() -> void:
	if is_instance_valid(_interactable):
		_interactable.pressed.disconnect(_on_change)

	for interactable in _interactables:
		interactable.hide()

func _on_change() -> void:
	if is_instance_valid(_interactable):
		change(_next, _interactable)

func update(_delta: float) -> void: pass
