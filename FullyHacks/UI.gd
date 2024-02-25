extends CanvasLayer

var score = 0.0

func _process(delta):
	score += delta
	$Label.text = "Score: " + str(int(score))
