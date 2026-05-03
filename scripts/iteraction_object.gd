extends Area2D
class_name IteractionObject

@export var action_name : String = "E - чтобы что-то сделать"
@export var expression_string : String = ""
@export var _disabled : bool = false

var player : PlayerCharacter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_deferred("monitoring", !_disabled)
	set_deferred("monitorable", !_disabled)
	self.body_entered.connect(notify_player_enter)
	self.body_exited.connect(notify_player_exit)

	
func notify_player_enter(body : Node2D) -> void:
	if body is PlayerCharacter :
		body = body as PlayerCharacter
		body.iteraction_area_entered(self)
		player = body
	
func notify_player_exit(body : Node2D) -> void:
	if body is PlayerCharacter :
		body = body as PlayerCharacter
		body.iteraction_area_exited(self)
	
func on_button_pressed() -> void :
	var expression : Expression = Expression.new()
	expression.parse(expression_string)
	expression.execute([], GManager)