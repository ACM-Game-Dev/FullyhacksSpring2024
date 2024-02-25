extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction
var chase = true
var charged = false
var closest_spire = null
var attacking = false
@onready var player = %Player
@onready var game = player.get_parent()
@onready var health = 50 + (10 * (game.difficulty - 1))
@onready var attack = 2 + (2 * (game.difficulty -1))
@onready var spires = %Spires
@onready var siphon_timer = $PlayerDetection/Siphon
@onready var attacktimer = $"PlayerDetection/Attack Timer"




# Called when the node enters the scene tree for the first time.
func _ready():
	#populate_points()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	find_player()
	if chase:
		direction = (closest_spire.global_position - self.global_position).normalized()
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	elif charged:
		direction = (player.global_position - self.global_position).normalized()
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


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = true

func find_player():
	var target_spire
	var min_distance = INF
	for spire in spires.get_children():
		var this_distance = (spire.global_position.x - global_position.x) + (spire.global_position.y - global_position.y)
		if (this_distance < min_distance):
			min_distance = this_distance
			target_spire = spire
	closest_spire = target_spire



func _on_siphon_timeout():
	chase = false
	charged = true
	health *= 3
	SPEED *= 2
	# Call function to remove energy


func _on_player_detection_area_entered(area):
	# I have no idea how to define this so I just called all 4
	if area.name == "Spire" || "Spire2" || "Spire3" || "Spire4":
		siphon_timer.start()
		
func damage_player():
	player.take_damage(attack)
	attacking = false
	attacktimer.start()


func _on_attack_timer_timeout():
	attacking = true
