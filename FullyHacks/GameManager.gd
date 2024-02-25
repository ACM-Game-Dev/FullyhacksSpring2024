extends Node2D

const SPAWN_LOCATIONS = {
	spawn_left = Vector2(-276,0),
	spawn_right = Vector2(270,0),
	spawn_top = Vector2(0,-270),
	spawn_bottom = Vector2(0,270),
}

var spawn_delay = 2

var time = 0
var time_since_spawn = spawn_delay
var difficulty = 1
var time_speed = 0.1

var melee_enemy = preload("res://Melee.tscn")
var gameover_scene = preload("res://game_over.tscn")


func check_spawn_monster():
	if time_since_spawn >= spawn_delay:
		spawn_robots()
		time_since_spawn = 0

func choose_spawn(val):
	if val < 0.25:
		return SPAWN_LOCATIONS.spawn_left
	elif val < 0.50:
		return SPAWN_LOCATIONS.spawn_right
	elif val < 0.75:
		return SPAWN_LOCATIONS.spawn_top
	elif val < 1:
		return SPAWN_LOCATIONS.spawn_bottom

func spawn_robots():
	for i in range(difficulty):
		var new_spawn = melee_enemy.instantiate()
		add_child(new_spawn)
		var rand = randf()
		var spawn_pos = choose_spawn(rand)
		new_spawn.global_position = spawn_pos

func increase_time_speed():
	time_speed += 0.1

func decrease_time_speed():
	time_speed -= 0.1

func set_time_speed(val):
	time_speed = val

func _on_time_increment_timeout():
	time += time_speed
	time_since_spawn += time_speed
	
	difficulty = round((time / 20) + 1)

func get_difficulty():
	return difficulty
	
func _process(delta):
	check_spawn_monster()
	if Input.get_action_raw_strength("ui_cancel"):
		get_tree().quit()


