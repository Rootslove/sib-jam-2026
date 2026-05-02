extends Control


func _ready() -> void:
	%PlayButton.pressed.connect(on_play_pressed)
	
func on_play_pressed() -> void :
	SceneLoader.current_scene = self
	SceneLoader.load_scene("res://levels/Main.tscn")
