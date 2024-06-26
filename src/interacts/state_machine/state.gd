extends Node
class_name State

@export var _next: State
@export var _action: Action
@export var _interactables: Array[Interactable]

signal Transitioned
var active := false

func _ready() -> void:
	if is_instance_valid(_action):
		var interactable = _action.get_parent() as Interactable
		interactable.pressed.connect(func() -> void:
			if is_instance_valid(_action):
				if _action.act():
					_action.queue_free()
					Transitioned.emit(self, _next))

	for interactable in _interactables:
			interactable.hide()

func enter() -> void:
	for interactable in _interactables:
		interactable.show()

func exit() -> void:
	for interactable in _interactables:
		interactable.hide()

func update() -> void: pass
func physics_update() -> void: pass
