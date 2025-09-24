extends CanvasLayer

func update_health(value : int, max_value : int) -> void:
	%HealthBar.max_value = max_value
	%HealthBar.value = value
	%HealthLabel.text = "HP: %d / %d" % [value, max_value]
