extends Area2D

signal prox

const MAX_CHARGE = 100

var charging = false

var charge = 0
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	#if body == player:
	charging = true
	prox.emit()
	print("Player Entered!") # Replace with function body.


func _on_charge_timer_timeout():
	if charging:
		charge += 0.1
		print(charge)


func _on_body_exited(body):
	charging = false
	pass # Replace with function body.
