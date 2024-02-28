extends Area2D

signal prox

const MAX_CHARGE = 100
const CHARGE_RATE = 1
const CHARGE_FALLOFF_RATE = 0.25

var charging = false

var charge = 0
static var global_charge = 0
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	charge = clamp(charge, 0, MAX_CHARGE)
	$PointLight2D.energy = 1 - charge / 100
	#print("Collective Charge:", str(global.collective_charge))

func _on_body_entered(body):
	if body.has_method("gain_energy"):
		player = body
		charging = true
		%AudioStreamPlayer2D.stream = load("res://Art/Retro Charge Off StereoUP 02.wav")
		%AudioStreamPlayer2D.play()
		prox.emit()
		print("Player Entered, Charging Up!")


func _on_charge_timer_timeout():
	if charging:
		if charge < MAX_CHARGE:
			charge += CHARGE_RATE
			global_charge += CHARGE_RATE
			player.gain_energy(2)
		
	if not charging and charge > 0:
		charge -= CHARGE_FALLOFF_RATE
		global_charge -= CHARGE_FALLOFF_RATE

func _on_body_exited(body):
	if body.has_method("gain_energy"):
		%AudioStreamPlayer2D.stream = load("res://Art/Retro Charge StereoUP 12.wav")
		%AudioStreamPlayer2D.play()
		charging = false
		print("Charging Stopped!")

func get_global_charge():
	return global_charge
