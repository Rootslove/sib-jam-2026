extends CanvasLayer
class_name Hud

@export var player : PlayerCharacter

func show_action(action : String) :
	hide_action()
	%ActionContainer.visible = true
	%ActionButton.text = action

func show_hint(hint : String) :
	hide_action()
	%HitnContainer.visible = true
	%HintLabel.text = hint
	
func hide_action() :
	%ActionContainer.visible = false
	%HitnContainer.visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ActionButton.pressed.connect(on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_button_pressed() -> void :
	player.current_iteraction.on_button_pressed()