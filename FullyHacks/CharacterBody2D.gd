extends CharacterBody2D

signal player_death
signal melee
signal ranged
signal melee_hold
signal spire_enter


var bullet = preload("res://rad_particle.tscn")


const SPEED = 300.0
const MAX_ENERGY = 100
const MELEE_COOLDOWN = 0.6
const RANGED_COOLDOWN = 0.1

var melee_damage = 25.0
var ranged_damage = 50.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var prevVelocity = Vector2.ZERO

var energy = 100
var mouse_pos = Vector2.ZERO

var can_melee = true
var can_ranged = true

func take_damage(damage):
	energy -= damage
	handle_death()

func handle_death():
	if energy <= 0:
		player_death.emit()

func update_aim():
	mouse_pos = get_global_mouse_position()
	#print(mouse_pos)

func check_melee():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_melee:
		melee.emit(melee_damage)

func check_ranged():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and can_ranged:
		ranged.emit()

func _physics_process(delta):
	$PointLight2D.energy = energy /75.0
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("move_down", "move_up")

	if direction_x or direction_y:
		velocity.x = direction_x * SPEED
		velocity.y = direction_y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0 , SPEED)

	velocity.x = lerp(prevVelocity.x,velocity.x, 0.1)
	velocity.y = lerp(prevVelocity.y,velocity.y, 0.1)
	prevVelocity = velocity

	update_aim()

	look_at(mouse_pos)
	check_melee()
	check_ranged()
	#print(energy)
	move_and_slide()


func _on_melee(val):
	#print("MELEE'D")
	can_melee = false
	
	%MeleeTimer.wait_time = MELEE_COOLDOWN
	%MeleeTimer.start()

func _on_ranged():
	print("RANGED'D")
	if energy >= 5:
		var new_bullet = bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.global_position = %Arm.global_position
		new_bullet.global_rotation = %Arm.global_rotation
		energy -= 5
	
	can_ranged = false
	%RangedTimer.wait_time = RANGED_COOLDOWN
	%RangedTimer.start()

func _on_melee_timer_timeout():
	can_melee = true

func _on_ranged_timer_timeout():
	can_ranged = true

func gain_energy(val):
	if energy <= MAX_ENERGY:
		energy += val
