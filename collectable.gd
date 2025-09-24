extends Area2D

class_name Collectable

func _ready():
	self.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		process_collectable(body)
		queue_free()

func process_collectable(body: Node2D):
	push_error("process_collectable not implemented!")
