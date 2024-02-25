extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = %Player
@onready var game = player.get_parent()
var direction
@onready var health = 50 + (10 * (game.difficulty - 1))
@onready var attack = 5 + (1 * (game.difficulty -1))
var chase = true
var attacking = false

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
	if attacking:
		damage_player()
		print (player.energy)
	move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		attacking = true
	if body.name == "Attack":
		health -= 10


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		attacking = false

func damage_player():
	player.take_damage(attack)