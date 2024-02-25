extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var game = get_parent()
@onready var player = game.get_node("Player")
var direction
@onready var health = 50 + (10 * (game.difficulty - 1))
@onready var attack = 1 + (1 * (game.difficulty -1))
var chase = true
var attacking = false
@onready var attacktimer = $PlayerDetection/Attack_Timer

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
		attacktimer.stop()

func damage_player():
	player.take_damage(attack)
	attacking = false
	attacktimer.start()


func _on_attack_timer_timeout():
	attacking = true
