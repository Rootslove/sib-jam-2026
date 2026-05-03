extends ProgressBar


@export var table : CookingTable

func _process(delta: float) -> void:
	value = table.shell.sides_amount % 20
	%SidesProgressText.text = GManager.sides_levels[clampf(table.shell.sides_amount / 20, 0, 4)]
