extends Side

@export var state: State

func _ready() -> void:
	state.get_parent().changed.connect(func(_from: State, to: State) -> void:
		if to == state: Global.game.fan_turned_on.emit())
