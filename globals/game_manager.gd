extends Node
class_name GameManager

signal dialogue_finished(id : String)

var shots_needed : int = 0
var dialogue : DialogRes
var player : PlayerCharacter
var salt_levels : Array[String] = ["не соленый", "слабосоленый", "соленый", "пересолил", "да тут одна соль!"]
var shots_required_amount : int = 0

func _ready() -> void:
	dialogue = DialogRes.new()
	dialogue.id = "adffgg"
	dialogue.phrases.append("Не спать, не спать! Стерлять!! Стрелять!!!")
	dialogue.speaker = "Голоса в голове"

func sleep(new_scene_path : String) -> void:
	print(shots_needed)
	if shots_needed > 0 :
		SceneLoader.play_animation()
		player.hud.start_dialogue(dialogue)
		return
	print("sleep well, fella")
	SceneLoader.load_scene(new_scene_path, true)
	await SceneLoader.load_finished
	
	