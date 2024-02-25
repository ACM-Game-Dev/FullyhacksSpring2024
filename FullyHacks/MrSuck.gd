extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var spires = %Spires
var direction
var health
var chase = true
var closest_spire = null
var visited_point = true
var astar = AStar2D.new()
var zero_point = Vector2(0,0)


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
	#elif !visited_point :
		#var closest_point = astar.get_closest_point(global_position)
		#direction = (astar.get_point_position(closest_point) - self.global_position).normalized()
		#velocity.x = direction.x * SPEED
		#velocity.y = direction.y * SPEED
		#if direction == zero_point:
			#visited_point = true
			#chase = true
	else:
		velocity.x = 0
		velocity.y = 0
	move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "Spire":
		chase = false
	if body.name == "Attack":
		health -= 10


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

#func populate_points():
	## 1 = West, 2 = East, 3 = North, 4 = South
	#astar.add_point(1, Vector2(-134,240))
	#astar.add_point(2, Vector2(200,240))
	#astar.add_point(3, Vector2(0, 6))
	#astar.add_point(4, Vector2(0,420))
