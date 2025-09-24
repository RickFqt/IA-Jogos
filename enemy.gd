extends CharacterBody2D

var max_health = 10
var health = 10

func _ready():
	health = max_health

func take_damage(damage : int) -> void:
	health = max(0, health - damage)
	if health <= 0:
		queue_free()
