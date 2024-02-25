extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = %Player
var direction
var health
var chase = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = (player.global_position - self.global_position).normalized()
	if chase == true:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = false
	if body.name == "Attack":
		health -= 10


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = true
