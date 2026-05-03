extends Camera2D
class_name HmCamera

@export var left_limit : int
@export var right_limit : int
@export var follow_speed : float =  7.0

@export var target : Node2D

func _ready() -> void:
	position_smoothing_enabled = false

func _physics_process(delta: float) -> void:
	if not target :
		return
	var target_pos : Vector2 = global_position
	target_pos.x = target.global_position.x
	target_pos = target_pos.round()
	if abs(target_pos.x - global_position.x) < 2 :
		return
	var weight : float = 1.0 - exp(-follow_speed * delta)
	global_position = global_position.lerp(target_pos, weight)
	global_position.x = clampf(global_position.x, left_limit, right_limit)
