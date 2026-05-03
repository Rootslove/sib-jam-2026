extends CharacterBody2D
class_name Sider

@export var table : CookingTable

@export var side : PackedScene
@export var anchor : Node2D
@export var salting_intensity : float = 3
@export var velocity_threshold : float = 900
@export var radius : float = 50

@export var sides : Array[Spice]

var is_carried : bool = false
var last_big_y_velocity_sign : bool = false

func _ready() -> void:
	input_pickable = true
	
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed && not is_carried:
		is_carried = true
		for i : int in range(15) :	
			var _side : Spice  = side.instantiate()
			_side.freezed = true
			_side.position = Vector2(radius*randf() - 25, radius*randf() - 25)
			_side.do_rotate = true
			_side.table = table
			sides.append(_side)
			add_child(_side)

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
		if is_carried :
			velocity = (get_global_mouse_position() - global_position) * delta * 1600
			move_and_slide()
	else :
		drop()
		position = Vector2(0, 0)
		is_carried = false

func  drop() -> void:
	for _side : Spice in sides :
		_side.reparent(get_parent(), true)
		_side.freezed = false
	sides.clear()