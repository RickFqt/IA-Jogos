extends Collectable

var heal_amount = 10

func process_collectable(playerbody: Node2D):
	playerbody.heal(heal_amount)
