extends IteractionObject
class_name Gun

@export var shoot_string = "Е - выстрелить!"
@export var hint_string = "нет снаряда"

var is_firing : bool = false

func _ready() -> void:
	super()
	%AnimatedSprite2D.animation_finished.connect(on_animation_finished)

func notify_player_enter(body : Node2D) -> void:
	super(body)
	if %AnimatedSprite2D.is_playing() || is_firing :
		return
	if player.carried_item == null :
		player.hud.show_hint(hint_string)
	else :
		player.hud.show_action(shoot_string)

func on_button_pressed() -> void:
	player.drop_item().queue_free()
	player.hud.hide_action()
	%AnimatedSprite2D.play("fire")
	is_firing = true

func on_animation_finished() -> void:
	if is_firing :
		%AnimatedSprite2D.play("fire", -1, true)
		is_firing = false
	else :
		var bodies = get_overlapping_bodies()
		if not bodies.is_empty() :
			notify_player_enter(bodies[0])