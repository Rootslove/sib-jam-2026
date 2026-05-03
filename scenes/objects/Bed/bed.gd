extends IteractionObject
class_name Bed

@export_file var next_scene : String

func on_button_pressed() -> void:
	GManager.sleep(next_scene)