extends IteractionObject
class_name TableObj

@export var nothing_to_coock_str : String = "возьмите снаряд"
@export var start_cooking_str : String = "Е - начать готовить"


func notify_player_enter(body : Node2D) -> void:
	super(body)
	if player.carried_item != null :
		player.hud.show_action(start_cooking_str)
	else :
		player.hud.show_hint(nothing_to_coock_str)
		
func on_button_pressed() -> void:
	SceneLoader.load_scene("res://levels/cooking/CookingTable.tscn", true)