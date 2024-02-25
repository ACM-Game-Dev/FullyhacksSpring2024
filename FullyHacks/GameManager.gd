extends Node2D

const SPAWN_LOCATIONS = {
	spawn_one = Vector2()
}

var spawn_delay = 20

var time = 0
var time_since_spawn = spawn_delay - 5
var difficulty = 1
var time_speed = 0.1


func check_spawn_monster():
	if time_since_spawn >= spawn_delay:
		spawn_robots()
		time_since_spawn = 0

func spawn_robots():
	print("SPAWNED ROBOTS")

func increase_time_speed():
	time_speed += 0.1

func decrease_time_speed():
	time_speed -= 0.1

func set_time_speed(val):
	time_speed = val

func _on_time_increment_timeout():
	time += time_speed
	time_since_spawn += time_speed
	#print(time)
	
func _process(delta):
	check_spawn_monster()
