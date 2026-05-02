extends Node2D

@export var he_shell : PackedScene
var is_ready : bool = false

func _ready() -> void:
	if is_ready :
		return
		
	%Shelve.add_shell(he_shell.instantiate())
	%Shelve.add_shell(he_shell.instantiate())
	%Shelve.add_shell(he_shell.instantiate())
	%Shelve.add_shell(he_shell.instantiate())
	is_ready = true
	
	
