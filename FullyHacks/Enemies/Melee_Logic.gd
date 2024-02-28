extends CharacterBody2D

const DEFAULT_SPEED = 50
var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var game = get_parent()
@onready var difficulty = game.get_difficulty()
@onready var player = game.get_node("Player")
@onready var spire = game.get_node("Spires").get_node("Spire1")
var direction
@onready var max_health = 50 + (10 * (game.difficulty - 1))
@onready var health = max_health
@onready var attack = 1 + (1 * (game.difficulty -1))
var chase = true
var attacking = false
@onready var attacktimer = $PlayerDetection/Attack_Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_speed():
	SPEED = DEFAULT_SPEED + spire.get_global_charge()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$PointLight2D.energy = health / max_health
	direction = (player.global_position - self.global_position).normalized()
	if chase == true:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = 0
		velocity.y = 0
	if attacking:
		damage_player()
		#print(player.energy)
	update_speed()
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
	
func take_damage(val):
	health -= val
	print(health)
	if health <= 0:
		queue_free()


func _on_attack_timer_timeout():
	attacking = true
