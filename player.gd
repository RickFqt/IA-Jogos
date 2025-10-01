extends CharacterBody2D
const speed = 200.0

var max_health = 100
var health
signal health_changed

func _ready():
	health = max_health
	set_area_proximity_detector()

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_pressed("move_left"):
		%AnimatedSprite2D.scale.x = - abs(%AnimatedSprite2D.scale.x)
	elif Input.is_action_pressed("move_right"):
		%AnimatedSprite2D.scale.x = abs(%AnimatedSprite2D.scale.x)
	
	if !is_moving():
		%AnimatedSprite2D.play("idle")
	else:
		%AnimatedSprite2D.play("walking")
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		var damage_taken = 0
		for mob in overlapping_mobs:
			if mob.is_in_group("Enemy"):
				damage_taken += mob.damage
		health -= damage_taken * delta
		health_changed.emit()

func is_moving() -> bool:
	return (Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left") || 
			Input.is_action_pressed("move_up") || Input.is_action_pressed("move_down"))

func heal(amount : int) -> void:
	health = min(max_health, health + amount)
	health_changed.emit()

func set_area_proximity_detector():
	
	
	var camera_size = get_viewport_rect().size
	camera_size *= 1.2
	$ProximityDetector/CollisionShape2D.shape.size = camera_size
	


func _on_proximity_detector_area_entered(area: Area2D) -> void:
	if area.get_parent().get_parent().is_in_group("Chunk"):
		area.get_parent().get_parent().set_active(true)

func _on_proximity_detector_area_exited(area: Area2D) -> void:
	if area.get_parent().get_parent().is_in_group("Chunk"):
		area.get_parent().get_parent().set_active(false)
