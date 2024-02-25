extends Node

var collective_charge: int = 0

func _ready():
	collective_charge = clamp(collective_charge, 0, 400)


