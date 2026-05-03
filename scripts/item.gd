extends Node2D
class_name Item

@export var item_name : String
@export var shell_type : SHELL_TYPE

var salt_amount : int
var sides_amount : int


enum SHELL_TYPE {
	HE,
	SMOKE
}