extends IteractionObject
class_name Gun

@export var shoot_string = "Е - выстрелить!"
@export var hint_string = "нет снаряда"
@export var eat_it : DialogRes
@export var not_enough_salt : DialogRes
@export var reqs : Array[ShellRequirements]
var cur_req_idx : int = 0

var game_end : PackedScene = preload("uid://cn0gv22ngt86w")

var is_firing : bool = false

func _ready() -> void:
	super()
	%AnimatedSprite2D.animation_finished.connect(on_animation_finished)

func _physics_process(delta: float) -> void:
	if %AnimatedSprite2D.frame == 10 && is_firing :
		%Fire.play()
	if %AnimatedSprite2D.frame == 9 && !is_firing :
		%Rotate.play()

func notify_player_enter(body : Node2D) -> void:
	super(body)
	if %AnimatedSprite2D.is_playing() || is_firing :
		player.hud.hide_action()
		return
	if player.carried_item == null :
		player.hud.show_hint(hint_string)
	else :
		player.hud.show_action(shoot_string)

func on_button_pressed() -> void:
	if not check_reqs() :
		player.hud.hide_action()
		return
	player.drop_item().queue_free()
	player.hud.hide_action()
	%AnimatedSprite2D.play("fire")
	is_firing = true
	%Rotate.play()
	GManager.shots_needed -= 1
	if player.is_shell :
		player.queue_free()
		get_tree().root.add_child(game_end.instantiate())

func on_animation_finished() -> void:
	if is_firing :
		%AnimatedSprite2D.play("fire", -1, true)
		is_firing = false
		if GManager.shots_needed <= 0 :
			if player && player.end_level_dialog :
				player.hud.start_dialogue(player.end_level_dialog)
	else :
		var bodies = get_overlapping_bodies()
		if not bodies.is_empty() :
			notify_player_enter(bodies[0])

func check_reqs() -> bool:
	if reqs.is_empty() || reqs.size() <= cur_req_idx:
		return true
	if player.carried_item.salt_amount < reqs[cur_req_idx].salt_level :
		player.hud.start_dialogue(not_enough_salt)
		return false
	if player.carried_item.salt_amount > reqs[cur_req_idx].salt_level + 10 :
		player.hud.start_dialogue(eat_it)
		return false
	if reqs[cur_req_idx].reqs_met_dialogue :
		player.hud.start_dialogue(reqs[cur_req_idx].reqs_met_dialogue)
	cur_req_idx += 1
	return true
