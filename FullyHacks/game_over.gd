extends Control


var game_scene = preload("res://map.tscn")
@onready var score = Score.score


func _on_button_pressed():
	get_tree().change_scene_to_packed(game_scene)
	
func _process(delta):
	%Label2.text = "You earned a score of: " + str(int(score))
