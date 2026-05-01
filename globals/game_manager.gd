extends Node
class_name GameManager

signal dialogue_finished(id : String)

var player : PlayerCharacter

func sleep() -> void:
	print("sleep well, fella")
	SceneLoader.load_scene("res://levels/Main.tscn")
	await SceneLoader.load_finished
	
