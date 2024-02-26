extends AnimatedSprite2D

const ANIMATIONS = {
	melee_swing = "melee_swing",
	idle = "idle"
}

func _ready():
	animation = ANIMATIONS.idle

func _on_player_melee(val):
	play(ANIMATIONS.melee_swing)


func _on_animation_finished():
	play(ANIMATIONS.idle)

