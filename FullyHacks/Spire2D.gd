extends Area2D

signal prox

const MAX_CHARGE = 100
const CHARGE_RATE = 1
const CHARGE_FALLOFF_RATE = 0.5

var charging = false

var charge = 0
var player = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	charge = clamp(charge, 0, 10)

func _on_body_entered(body):
	if body.has_method("_player"):
		charging = true
		prox.emit()
		print("Player Entered, Charging Up!")


func _on_charge_timer_timeout():
	if charging and charge < MAX_CHARGE:
		charge += CHARGE_RATE
		print(charge)
	if not charging:
		charge -= 0.05


func _on_body_exited(body):
	if body.has_method("_player"):
		charging = false
		print("Charging Stopped!")
