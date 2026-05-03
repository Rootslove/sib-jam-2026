extends CharacterBody2D
class_name Salter

@export var table : CookingTable

@export var salt : PackedScene
@export var anchor : Node2D
@export var salting_intensity : float = 3
@export var velocity_threshold : float = 900

var is_carried : bool = false
var last_big_y_velocity_sign : bool = false

func _ready() -> void:
	input_pickable = true
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		is_carried = true

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
		if is_carried :
			velocity = (get_global_mouse_position() - global_position) * delta * 1600
			move_and_slide()
	else :
		is_carried = false	
	if abs(velocity.y) > velocity_threshold :
		if last_big_y_velocity_sign != (velocity.y > 0) :
			last_big_y_velocity_sign = !last_big_y_velocity_sign
			var new_salt : Spice = salt.instantiate()
			get_parent().add_child(new_salt)
			new_salt.table = table
			new_salt.global_position = %SpawnPoint.global_position
			
