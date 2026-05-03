extends Node2D
class_name CookingTable

@export var salter : Salter

@export var shell : Item
@export var shell_anchor : Node2D

func _ready() -> void:
	print("reparenting " + str(GManager.player.carried_item))
	GManager.player.carried_item.reparent(shell_anchor, false)
	shell = GManager.player.carried_item
	%ExitButton.pressed.connect(exit)
	shell.scale = Vector2(7, 7)

func _exit_tree() -> void:
	shell.scale = Vector2(1, 1)
	shell.reparent(GManager.player.item_marker, false)
	shell = null

func exit() -> void:
	SceneLoader.load_previous()
