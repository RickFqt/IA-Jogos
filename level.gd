extends Node2D

var Quadrado = preload("res://area.tscn")

@onready var player = %Player
@onready var hud = %Hud

func _ready():
	set_up(3, 3)
	hud.update_health(player.health, player.max_health)
	player.health_changed.connect(
		func():
			hud.update_health(player.health, player.max_health)
	)
		
func set_up(linhas : int, colunas : int):
	var size = 700
	for x in range(linhas):
		for y in range(colunas):
			var q = Quadrado.instantiate()
			q.position = Vector2(x*size, y*size)
			$Grid.add_child(q)
