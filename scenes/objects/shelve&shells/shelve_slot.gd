extends Marker2D
class_name ShelveSlot

var shell : Item = null


func is_occupied() -> bool:
	return shell != null

func occupy(new_shell : Item) -> void:
	shell = new_shell
	add_child(shell)
	
func take_shell() -> Item :
	remove_child(shell)
	var shell_to_return = shell
	shell = null
	return shell_to_return
	
