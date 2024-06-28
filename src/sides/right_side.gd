extends Side

func _ready() -> void:
	$RoleOfCode.hide()
	Global.game.fan_turned_on.connect($RoleOfCode.show)
