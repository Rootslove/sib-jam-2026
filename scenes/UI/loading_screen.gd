extends CanvasLayer
class_name LoadingScreen

signal loading_screen_ready

func _ready() -> void:
	await %AnimationPlayer.animation_finished
	loading_screen_ready.emit()

func on_load_finished() -> void :
	%AnimationPlayer.play_backwards("transition")
	await %AnimationPlayer.animation_finished
	queue_free()