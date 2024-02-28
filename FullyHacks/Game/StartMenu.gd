extends Control


var mapScene = preload("res://Game/map.tscn")
var charging = true
#var tween = get_tree().create_tween()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_pressed():
	get_tree().change_scene_to_packed(mapScene)


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	if(charging):
		tween.tween_property($AnimatedSprite2D/PointLight2D, "energy", 1.5, 2)
		tween.tween_property($AnimatedSprite2D/PointLight2D, "scale", 3, 2)
		charging = false
	elif(not charging):
		tween.tween_property($AnimatedSprite2D/PointLight2D, "energy", 0, 2)
		tween.tween_property($AnimatedSprite2D/PointLight2D, "scale", 1.5, 2)
		charging = true
