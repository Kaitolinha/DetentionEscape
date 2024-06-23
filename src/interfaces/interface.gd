class_name Interface
extends CanvasLayer

@export var _spawn: Node
@export var _left_arrow: Button
@export var _right_arrow: Button
@export var _up_arrow: Button
@export var _down_arrow: Button
@export var _left_messages: VBoxContainer
@export var _right_messages: VBoxContainer
@export var slots: VBoxContainer

var slot_focused: Slot

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

		_left_messages.add_child(label)
		await get_tree().create_timer(2).timeout
		_left_messages.remove_child(label))

	# Slot messages.
	Global.game.message.slot_sent.connect(func(message: StringName) -> void:
		var label := Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		label.text = message

		_right_messages.add_child(label)
		await get_tree().create_timer(2).timeout
		_right_messages.remove_child(label))

	# Inventory.
	assert(slots.get_child_count() == 0, "The slots container must be empty.")

	var create = func(scene: PackedScene) -> void:
		var slot = scene.instantiate()
		slot.interface = self
		slot.focus(false)
		slots.add_child(slot)

	var slot_scene = preload("res://src/interfaces/slot.tscn")
	for index in Global.game.inventory.size():
		create.call(slot_scene)

	Global.game.inventory.refreshed.connect(func(index: int) -> void:
		assert(slots.get_child_count() == Global.game.inventory.size(),
			"The slots container must have %d children." % Global.game.inventory.size())
		slots.get_child(index).refresh())

	Global.game.inventory.removed.connect(func(index: int) -> void:
		slots.get_child(index).queue_free())

	Global.game.inventory.focused.connect(func(index: int, enable: bool) -> void:
		var item: Item = Global.game.inventory.get_item(index)
		if is_instance_valid(item) and enable:
			Global.game.message.send(Message.MessageIn.RIGHT, item.title)
		slots.get_child(index).focus(enable))

	Global.game.inventory.inserted.connect(func(index: int) -> void:
		var item: Item = Global.game.inventory.get_item(index)
		if is_instance_valid(item):
			Global.game.message.send(Message.MessageIn.RIGHT, item.title)
		if index == slots.get_child_count():
			create.call(slot_scene))
