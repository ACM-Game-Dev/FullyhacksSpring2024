extends Node2D

var speed = 35
var direction = Vector2.RIGHT

func _process(delta):
	direction = Vector2.RIGHT.rotated(rotation)
	position.x += direction.x * speed
	position.y += direction.y * speed

func _on_area_2d_area_entered(area):

	queue_free()
		

func _on_area_2d_body_entered(body):
	if body.name != "Player":
		queue_free()
		

func _on_timer_timeout():
	queue_free()



