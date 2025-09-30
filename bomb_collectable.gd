extends Collectable

var damage = 10

func process_collectable(playerbody: Node2D):
	var bodies = %DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemy"):
			body.take_damage(damage)
