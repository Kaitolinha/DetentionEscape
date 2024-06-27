class_name OtherActionState
extends State

@export var other_next: State
@export var other_interactable: Interactable

func _ready() -> void:
	if is_instance_valid(other_interactable):
		_interactables.append(other_interactable)
	super._ready()

func enter() -> void:
	if is_instance_valid(other_interactable):
		other_interactable.pressed.connect(_on_other_change)
	super.enter()

func exit() -> void:
	if is_instance_valid(other_interactable):
		other_interactable.pressed.disconnect(_on_other_change)
	super.exit()

func _on_other_change() -> void:
	if is_instance_valid(other_interactable):
		change(other_next, other_interactable)
