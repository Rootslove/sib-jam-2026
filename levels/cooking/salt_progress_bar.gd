extends ProgressBar

@export var table : CookingTable

func _process(delta: float) -> void:
	value = table.shell.salt_amount % 10
	%SaltProgressText.text = GManager.salt_levels[clampf(table.shell.salt_amount / 10, 0, 4)]
