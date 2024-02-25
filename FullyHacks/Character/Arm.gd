extends Area2D

func _on_hit_reset_timeout():
	#print("Arm untouchable")
	set_collision_layer_value(2,false)
