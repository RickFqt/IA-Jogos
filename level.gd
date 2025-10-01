extends Node2D

var QuadradoScene = preload("res://area.tscn")
var EnemyScene = preload("res://enemy.tscn")
var HealthItemScene = preload("res://life_collectable.tscn")
var BombItemScene = preload("res://bomb_collectable.tscn")

@export var items_per_area = 3
@export var enemies_per_area = 4

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
			var q = QuadradoScene.instantiate()
			q.position = Vector2(x*size, y*size)
			$Grid.add_child(q)
			
			var spawn_points = []
			for marker in q.get_node("Content/SpawnPoints").get_children():
				var global_pos = q.position + marker.position
				spawn_points.append(global_pos)
			
			for i in range(enemies_per_area):
				if spawn_points.is_empty():
					break
				var pos = spawn_points.pick_random()
				spawn_points.erase(pos)
				var enemy = EnemyScene.instantiate()
				enemy.position = pos
				%Enemies.add_child(enemy)
			
			for i in range(items_per_area):
				if spawn_points.is_empty():
					break
				var pos = spawn_points.pick_random()
				spawn_points.erase(pos)
				var scene = [HealthItemScene, BombItemScene].pick_random()
				var item = scene.instantiate()
				item.position = pos
				%Collectables.add_child(item)
				

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_camera"):
		if %GlobalView.is_current():
			%Player/Camera2D.make_current()
		else:
			%GlobalView.make_current()
