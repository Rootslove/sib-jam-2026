extends IteractionObject
class_name Radio

@export var dialog : Array[DialogRes]
@export var listen_to_radio_str : String = "Прослушайте входящую передачу"
@export var start_radio_str : String = "Е - Выйти на связь"
@export var no_signal_str : String = "Только помехи"
var cur_dialog_idx : int = 0

var transmission_in_progress : bool = false

func _ready() -> void:
	super()
	GManager.dialogue_finished.connect(ended_transmission)

func notify_player_enter(body : Node2D) -> void:
	super(body)
	if transmission_in_progress :
		player.hud.show_hint(listen_to_radio_str)
		return
	if cur_dialog_idx == dialog.size() :
		player.hud.show_hint(no_signal_str)
		return
	player.hud.show_action(start_radio_str)

func on_button_pressed() -> void:
	if dialog.size() <= cur_dialog_idx :
		return
	player.hud.start_dialogue(dialog[cur_dialog_idx])
	transmission_in_progress = true
	player.hud.show_hint(listen_to_radio_str)
	cur_dialog_idx += 1
	
func ended_transmission(dialog_id : String) -> void :
	transmission_in_progress = false
