class_name SceneAction
extends Action

@export var scene: PackedScene

func act() -> bool:
	get_tree().change_scene_to_packed(scene)
	return true
