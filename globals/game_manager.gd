extends Node
class_name GameManager

func sleep() -> void:
	print("sleep well, fella")
	SceneLoader.load_scene("res://levels/Main.tscn")
