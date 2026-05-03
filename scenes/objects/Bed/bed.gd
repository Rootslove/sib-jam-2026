extends IteractionObject
class_name Bed

@export_file var next_scene : String

func on_button_pressed() -> void:
	SceneLoader.load_scene(next_scene)