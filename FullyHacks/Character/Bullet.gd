extends Node2D
@export var SPEED: int = 5
var direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	look_at(position + direction)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Vector2.RIGHT.rotated(rotation)
	position.x += direction.x * SPEED
	position.y += direction.y * SPEED


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.name("Player"):
		queue_free()
