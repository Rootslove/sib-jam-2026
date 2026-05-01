extends IteractionObject
class_name ShelveObj

@export var shell_slots : Array[ShelveSlot]
@export var take_shell_str : String = "E - взять снаряд"
@export var deposit_shell_str : String = "E - вернуть снаряд"
@export var no_shell_str : String = "пусто"

var is_empty = false

func add_shell(shell : Item) -> void:
	for slot : ShelveSlot in shell_slots :
		if not slot.is_occupied() :
			slot.occupy(shell)
			return

func notify_player_enter(body : Node2D) -> void:
	super(body)
	if player.carried_item != null :
		player.hud.show_action(deposit_shell_str)
	else :
		player.hud.show_action(take_shell_str)
	if is_empty :
		player.hud.show_action(no_shell_str)

func on_button_pressed() -> void:
	if player.carried_item != null :
		print("depositing")
		add_shell(player.drop_item())
		player.hud.show_action(take_shell_str)
	else :
		for slot : ShelveSlot in shell_slots :
			if slot.is_occupied() :
				player.carry_item(slot.take_shell())
				player.hud.show_action(deposit_shell_str)
				return
		is_empty = true
		player.hud.show_action(no_shell_str)