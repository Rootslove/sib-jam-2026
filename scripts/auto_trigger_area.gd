extends Area2D
class_name AutoTriggerArea

@export var object_to_trigger : IteractionObject

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body : Node2D) -> void:
	print("trigger")
	if object_to_trigger :
		object_to_trigger.on_button_pressed()