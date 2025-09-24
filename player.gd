extends CharacterBody2D
const speed = 200.0

var max_health = 100
var health
signal health_changed

func _ready():
	health = 2

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

func is_moving() -> bool:
	return (Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left") || 
			Input.is_action_pressed("move_up") || Input.is_action_pressed("move_down"))

func heal(amount : int) -> void:
	health = min(max_health, health + amount)
	health_changed.emit()
