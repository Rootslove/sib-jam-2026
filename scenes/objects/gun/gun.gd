extends IteractionObject
class_name Gun

@export var shoot_string = "Е - выстрелить!"
@export var hint_string = "нет снаряда"

func notify_player_enter(body : Node2D) -> void:
	super(body)
	if player.carried_item == null :
		player.hud.show_hint(hint_string)
	else :
		player.hud.show_action(shoot_string)

func on_button_pressed() -> void:
	player.drop_item().queue_free()
	player.hud.hide_action()
