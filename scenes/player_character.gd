extends CharacterBody2D
class_name PlayerCharacter 

@export var hud : Hud
var current_iteraction : IteractionObject
var carried_item : Item

@onready var item_marker : Node2D = %ItemMarker

@export var SPEED : float = 200.0
const JUMP_VELOCITY = -400.0

@export var is_shell : bool = false

func _ready() -> void:
	GManager.player = self
	if is_shell :
		%Sprite2D.visible = false
		%ShellSprite.visible = true

func _physics_process(delta: float) -> void:
	if not is_shell :
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		if velocity.length_squared() > 100 :
			%AnimationPlayer.play("walk")
			if velocity.x < 0 :
				%Sprite2D.flip_h = true
			else :
				%Sprite2D.flip_h = false
		else :
			%AnimationPlayer.play("idle")
	
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else :
		velocity.x = move_toward(velocity.x, 0, 16)

	move_and_slide()

func iteraction_area_entered(iObject : IteractionObject) -> void :
	hud.show_action(iObject.action_name)
	current_iteraction = iObject

func iteraction_area_exited(iObject : IteractionObject) -> void :
	hud.hide_action()
	current_iteraction = null
	
func carry_item(item : Node2D) -> void :
	carried_item = item
	%ItemMarker.add_child(item)
	
func drop_item() -> Node2D :
	var item_to_return : Node2D = carried_item
	%ItemMarker.remove_child(carried_item)
	carried_item = null
	return item_to_return

func _input(event: InputEvent) -> void:
	if not is_shell || abs(velocity.x) > 100:
		return
	if event.is_action_pressed("ui_left") :
		velocity.x = -400;
	if event.is_action_pressed("ui_right") :
		velocity.x = 400;