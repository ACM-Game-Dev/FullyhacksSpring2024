extends Area2D


	
	
const DAMAGE_VAL = 25


func _on_player_melee(val):
	print("Meled")
	for body in get_overlapping_bodies():
		print(body.name)
		if body.has_method("take_damage"):
			body.take_damage(val)
			
