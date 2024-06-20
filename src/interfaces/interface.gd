class_name Interface
extends CanvasLayer

@export var _spawn: Node
@export var _left_arrow: Button
@export var _right_arrow: Button
@export var _down_arrow: Button
@export var _up_arrow: Button
@export var _info_messages: VBoxContainer
@export var _slot_messages: VBoxContainer
@export var _slots: VBoxContainer

var slot_focus: Slot

func _ready():
	var room: Room = preload("res://src/core/room.tscn").instantiate()

	# Arrows.
	_left_arrow.pressed.connect(func() -> void: room.change(room.Direction.LEFT))
	_right_arrow.pressed.connect(func() -> void: room.change(room.Direction.RIGHT))
	_down_arrow.pressed.connect(func() -> void: room.change(room.Direction.DOWN))
	_up_arrow.pressed.connect(func() -> void: room.change(room.Direction.UP))

	_down_arrow.hide()
	room.ceiling_entered.connect(_down_arrow.show)
	room.ceiling_exited.connect(_down_arrow.hide)

	_spawn.add_child(room)

	# Information messages.
	Global.game.message.info_sent.connect(func(message: StringName) -> void:
		var label := Label.new()
		label.text = message

		_info_messages.add_child(label)
		await get_tree().create_timer(2).timeout
		_info_messages.remove_child(label))

	# Slot messages.
	Global.game.message.slot_sent.connect(func(message: StringName) -> void:
		var label := Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		label.text = message

		_slot_messages.add_child(label)
		await get_tree().create_timer(2).timeout
		_slot_messages.remove_child(label))

	# Inventory.
	assert(_slots.get_child_count() == 0, "The slots container must be empty.")
	for index in range(Global.game.inventory.capacity):
		var slot = preload("res://src/interfaces/slot.tscn").instantiate()
		slot.interface = self
		slot.index = index
		slot.focus(false)
		_slots.add_child(slot)

	Global.game.inventory.refreshed.connect(func(index: int) -> void:
		assert(_slots.get_child_count() == Global.game.inventory.capacity,
			"The slots container must have %d children." % Global.game.inventory.capacity)
		_slots.get_child(index).refresh())
