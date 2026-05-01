extends Node2D

@export var he_shell : PackedScene
func _ready() -> void:
	print("main scene loaded")
	%Shelve.add_shell(he_shell.instantiate())
	%Shelve.add_shell(he_shell.instantiate())
	%Shelve.add_shell(he_shell.instantiate())
	%Shelve.add_shell(he_shell.instantiate())
	
	
