extends PanelContainer
class_name DialoguePanel

@export_range(1, 100, 1) var characters_per_sec : int = 20
@export_range(0, 10, 0.1) var next_phrase_time_sec : float = 2
@export_range(0, 10, 0.1) var hide_time_sec : float = 2

var typing_timer : Timer
var phrase_timer : Timer
var hide_timer : Timer
var full_text : String
var cur_char_idx : int = 0

var cur_dialogue_id : String
var character_speaking : String = "..."
var current_dialogue : Array[String]
var current_phrase_idx : int = 0

func _ready() -> void:
	typing_timer = Timer.new()
	typing_timer.one_shot = false
	typing_timer.wait_time = 1.0/characters_per_sec
	typing_timer.timeout.connect(type)
	self.add_child(typing_timer)
	
	phrase_timer = Timer.new()
	phrase_timer.one_shot = true
	phrase_timer.wait_time = next_phrase_time_sec
	phrase_timer.timeout.connect(next_phrase)
	self.add_child(phrase_timer)
	
	hide_timer = Timer.new()
	hide_timer.one_shot = true
	hide_timer.wait_time = hide_time_sec
	hide_timer.timeout.connect(hide_self)
	self.add_child(hide_timer)
	
func type() -> void:
	if cur_char_idx != full_text.length() :
		%DialogueText.text += full_text[cur_char_idx]
		cur_char_idx += 1
	else :
		typing_timer.stop()
		phrase_timer.start()

func next_phrase() -> void:
	if current_phrase_idx != current_dialogue.size() :
		%DialogueText.text = ""
		cur_char_idx = 0
		full_text = current_dialogue[current_phrase_idx]
		current_phrase_idx += 1
		typing_timer.start()
	else :
		hide_timer.start()

func hide_self() -> void:
	GManager.dialogue_finished.emit(cur_dialogue_id)
	self.visible = false
	
func start_dialogue(dialog : DialogRes) -> void:
	if current_phrase_idx != current_dialogue.size() || cur_char_idx != full_text.length() :
		GManager.dialogue_finished.emit(cur_dialogue_id)
	%CharacterName.text = dialog.speaker
	self.visible = true
	cur_dialogue_id = dialog.id
	current_dialogue = dialog.phrases
	current_phrase_idx = 0
	next_phrase()
	