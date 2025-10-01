extends CanvasLayer

@onready var restart_button = $GameOver/VBoxContainer/RestartButton

func update_health(value : int, max_value : int) -> void:
	%HealthBar.max_value = max_value
	%HealthBar.value = value
	%HealthLabel.text = "HP: %d / %d" % [value, max_value]

func display_game_over() -> void:
	get_tree().paused = true
	$PlayerPanel.visible = false
	$GameOver.visible = true
	

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://level.tscn")
