extends CharacterBody2D
@onready var BULLET = preload("res://Bullet.tscn")
var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = %Player
var direction
var health
var chase = true
var is_moving = false
var reloaded = true
@onready var shoot_timer = $"PlayerDetection/Shoot Timer"
@onready var game = player.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()
	if (reloaded):
		shoot_bullet()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = false
	if body.name == "Attack":
		health -= 10

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = true

func shoot_bullet():
	look_at(player.global_position)
	reloaded = false
	var bullet = BULLET.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.rotation = rotation
	
		
	shoot_timer.start()

func move(): 
	direction = (player.global_position - self.global_position).normalized()
	if chase:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		is_moving = true
	else:
		velocity.x = 0
		velocity.y = 0
		is_moving = false
	move_and_slide()


func _on_shoot_timer_timeout():
	reloaded = true
