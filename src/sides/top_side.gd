extends Side

var _fan_force: int = 2

func _physics_process(delta: float) -> void:
	$Ventilador.rotation += _fan_force * delta
