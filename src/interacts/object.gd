extends Node2D

@export var frames: Array[State]

@onready var sprite = $Sprite as Sprite2D
@onready var state_machine = $StateMachine as StateMachine

func _ready() -> void:
	for index in frames.size():
		assert(frames[index].get_parent() == state_machine)

	if is_instance_valid(sprite) and !frames.is_empty():
		state_machine.changed.connect(func(_from: State, to: State) -> void:
			var index: int = frames.find(to)
			if index != -1:
				sprite.frame = index)
