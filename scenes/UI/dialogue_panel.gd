extends PanelContainer
class_name DialoguePanel

@export_range(1, 100, 1) var characters_per_sec : int = 20
@export_range(0, 10, 0.1) var next_phrase_timer : float = 2

var typing_timer : Timer
var phrase_timer : Timer
var full_text : String
var cur_char_idx : int = 0

var character_speaking : String = "..."
var current_dialogue : Array[String]
var current_phrase_idx : int = 0

func _ready() -> void:
	typing_timer = Timer.new()
	typing_timer.one_shot = false
	typing_timer.wait_time = 1.0/characters_per_sec
	typing_timer.timeout.connect(type)
	
func type() -> void:
	if cur_char_idx != full_text.length() :
		pass
