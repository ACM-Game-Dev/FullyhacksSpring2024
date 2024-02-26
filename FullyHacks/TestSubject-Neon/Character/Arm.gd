extends Area2D


	
	
const DAMAGE_VAL = 25

var hitsound = preload("res://Art/Retro Swooosh 02.wav")

func _on_player_melee(val):
	print("Meled")
	for body in get_overlapping_bodies():
		print(body.name)
		if body.has_method("take_damage"):
			%ArmSounds.stream = hitsound
			%ArmSounds.play()
			body.take_damage(val)
			
