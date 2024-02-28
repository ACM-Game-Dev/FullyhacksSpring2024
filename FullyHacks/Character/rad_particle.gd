extends Node2D

var speed = 35
var direction = Vector2.RIGHT
var damage = 50

func _process(_delta):
	direction = Vector2.RIGHT.rotated(rotation)
	position.x += direction.x * speed
	position.y += direction.y * speed
		

func _on_area_2d_body_entered(body):
	if body.name != "Player":
		if body.has_method("take_damage"):
			body.take_damage(50)
		queue_free()
		

func _on_timer_timeout():
	queue_free()



