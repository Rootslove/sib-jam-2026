extends Node
class_name GameManager

signal dialogue_finished(id : String)

var player : PlayerCharacter

func sleep(new_scene_path : String) -> void:
	print("sleep well, fella")
	SceneLoader.load_scene(new_scene_path, true)
	await SceneLoader.load_finished
	
	