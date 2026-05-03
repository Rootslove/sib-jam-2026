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
	%ResetButton.pressed.connect(clean_shell)
	shell.scale = Vector2(7, 7)

func _exit_tree() -> void:
	shell.scale = Vector2(1, 1)
	shell.reparent(GManager.player.item_marker, false)
	shell = null

func exit() -> void:
	SceneLoader.load_previous()
	
func clean_shell() -> void :
	shell.salt_amount = 0
	for child : Node2D in shell.get_child(1).get_children() :
		if child is Spice :
			child.queue_free()
	
