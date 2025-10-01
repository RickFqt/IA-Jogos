extends Node2D

@onready var content = $Content
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_up()
	set_process(true)

func _process(_delta):
	var player_inside = false
	for body in %AreaOfActivation.get_overlapping_bodies():
		if body.is_in_group("Player"):
			player_inside = true
			break
		
	set_active(player_inside)  # agora os inimigos já existem
	set_process(false) # só roda 1 vez

func set_up() -> void:
	var lines = 4
	var collumns = 4
	var square_size = %TextureRect.size.x
	var margin = square_size / 10
	var gap = (square_size - 2*margin) / lines
	
	for line in range(lines):
		for collumn in range(collumns):
			var marker = Marker2D.new()
			marker.position = Vector2(line*gap + margin, collumn*gap + margin)
			%SpawnPoints.add_child(marker)
	
func set_active(active : bool) -> void:
	#content.visible = active
	#content.set_process(active)
	#content.set_physics_process(active)
	#for child in content.get_children():
		#child.set_process(active)
		#child.set_physics_process(active)
	
	for body in %AreaOfActivation.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.set_process(active)
			body.set_physics_process(active)
			body.visible = active
	for area in %AreaOfActivation.get_overlapping_areas():
		if area.is_in_group("Collectable"):
			area.set_process(active)
			area.visible = active
