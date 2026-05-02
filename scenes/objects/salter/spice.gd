extends Area2D
class_name Spice

var termination_timer : Timer
var freeze_timer : Timer

@export var fall_velocity : float = 160
var velocity : Vector2 = Vector2.DOWN
var area : Area2D

func _ready() -> void:
	self.area_entered.connect(on_area_entered)
	termination_timer = Timer.new()
	termination_timer.one_shot = true
	termination_timer.wait_time = 30
	termination_timer.timeout.connect(queue_free)
	add_child(termination_timer)
	
	freeze_timer = Timer.new()
	freeze_timer.one_shot = true
	freeze_timer.wait_time = randf()*0.3
	freeze_timer.timeout.connect(attach_to_area)
	add_child(freeze_timer)
	
	termination_timer.start()


func on_area_entered(area2d: Area2D) -> void:
	if area == area2d :
		return
	area = area2d
	freeze_timer.start()

func _physics_process(delta: float) -> void:
	velocity = Vector2.DOWN * delta * fall_velocity
	global_position += velocity
	
func attach_to_area() -> void:
	termination_timer.stop()
	if get_overlapping_areas().is_empty() :
		return
	reparent(area, true)
	set_physics_process(false)
	set_deferred("disabled", true)