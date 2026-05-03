extends Area2D
class_name Spice

var termination_timer : Timer
var freeze_timer : Timer

@export var rotate_min_speed: float = 10.0
@export var rotate_max_speed: float = 30.0

var angular_speed: float = 0.0

@export var do_rotate : bool = false
@export var fall_velocity : float = 160
var velocity : Vector2 = Vector2.DOWN
var area : Area2D
var freezed : bool = false

var table : CookingTable

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
	if do_rotate :
		randomize()
		angular_speed = randf_range(rotate_min_speed, rotate_max_speed)
		if randi() % 2 == 0:
			angular_speed *= -1.0


func on_area_entered(area2d: Area2D) -> void:
	if area == area2d :
		return
	area = area2d
	freeze_timer.start()

func _physics_process(delta: float) -> void:
	if freezed :
		return
	velocity = Vector2.DOWN * delta * fall_velocity
	global_position += velocity
	if do_rotate :
		print(rotation)
		print(angular_speed)
		rotation += angular_speed * delta
	
func attach_to_area() -> void:
	termination_timer.stop()
	if get_overlapping_areas().is_empty() :
		return
	reparent(area, true)
	set_physics_process(false)
	set_deferred("disabled", true)
	
	if do_rotate :
		table.shell.sides_amount += 1
	else :
		table.shell.salt_amount += 1
