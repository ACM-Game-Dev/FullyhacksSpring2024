extends CharacterBody2D

signal player_death
signal melee
signal ranged
signal melee_hold

const SPEED = 300.0

const MELEE_COOLDOWN = 0.6
const RANGED_COOLDOWN = 0.05


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
		melee.emit()

func check_ranged():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and can_ranged:
		ranged.emit()
	
func _physics_process(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
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

	move_and_slide()


func _on_melee():
	print("MELEE'D")
	can_melee = false
	%MeleeTimer.wait_time = MELEE_COOLDOWN
	%MeleeTimer.start()

func _on_ranged():
	print("RANGED'D")
	can_melee = false
	%MeleeTimer.wait_time = MELEE_COOLDOWN
	%MeleeTimer.start()

func _on_melee_timer_timeout():
	can_melee = true

func _on_ranged_timer_timeout():
	can_melee = true
