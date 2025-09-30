extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_up()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	
