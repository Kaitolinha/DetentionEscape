class_name Interface
extends CanvasLayer

@export var _side_spawn: Node
@export var _left_arrow: Button
@export var _right_arrow: Button
@export var _info_messages: VBoxContainer
@export var _slot_messages: VBoxContainer
@export var _slots: VBoxContainer

var slot_focus: Slot

func _ready():
	Room.start(_side_spawn)

	# Arrows.
	_left_arrow.pressed.connect(Room.previous_side)
	_right_arrow.pressed.connect(Room.next_side)

	# Information messages.
	Message.info_sent.connect(func(message: StringName) -> void:
		var label: Label = Label.new()
		label.text = message

		_info_messages.add_child(label)
		await get_tree().create_timer(2).timeout
		_info_messages.remove_child(label))

	# Slot messages.
	Message.slot_sent.connect(func(message: StringName) -> void:
		var label: Label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		label.text = message

		_slot_messages.add_child(label)
		await get_tree().create_timer(2).timeout
		_slot_messages.remove_child(label))

	# Inventory.
	assert(_slots.get_child_count() == 0, "The slots container must be empty.")
	for index in range(Inventory.capacity):
		var slot: Slot = preload("res://src/interfaces/slot.tscn").instantiate()
		slot.interface = self
		slot.index = index
		slot.focus(false)
		_slots.add_child(slot)

	Inventory.refreshed.connect(func(index: int) -> void:
		assert(_slots.get_child_count() == Inventory.capacity,
			"The slots container must have %d children." % Inventory.capacity)
		_slots.get_child(index).refresh())
