extends CharacterBody2D

var max_health = 10
var health = 10
var damage = 10
var speed = 100
var player_ref : Node2D
var last_known_player_position : Vector2
var current_target : Vector2

enum State { IDLE, CHASE, SEARCH }

var current_state : State = State.IDLE

func _ready():
	health = max_health

func _physics_process(delta: float) -> void:
	
	var direction = Vector2()
	if current_state == State.CHASE:
		if player_ref and is_instance_valid(player_ref):
			current_target = player_ref.global_position
	elif current_state == State.SEARCH:
		current_target = last_known_player_position
		if close_enough(current_target):
			current_target = global_position
			current_state = State.IDLE
		
	if current_state != State.IDLE:
		direction = (current_target - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func take_damage(damage : int) -> void:
	health = max(0, health - damage)
	if health <= 0:
		queue_free()


func _on_area_of_sight_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_ref = body
		current_state = State.CHASE


func _on_area_of_sight_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		last_known_player_position = body.global_position
		player_ref = null
		current_state = State.IDLE

func close_enough(target : Vector2):
	var tolerance = 8
	return global_position.distance_to(target) <= 8
