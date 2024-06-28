extends State

@export var image: Sprite2D
@export var role_of_code_image: Sprite2D

func enter() -> void:
	role_of_code_image.queue_free()
	super.enter()

func exit() -> void:
	super.exit()

func update(delta: float) -> void:
	image.rotation += delta
