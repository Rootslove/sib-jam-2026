extends Node2D

@export var he_shell : PackedScene
@export var shots_needed : int = 1
var is_ready : bool = false

func _ready() -> void:
	GManager.shots_needed = shots_needed
	
