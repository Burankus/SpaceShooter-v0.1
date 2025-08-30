extends PathFollow2D

var speed = 0.15

func _process(delta):
	progress_ratio += delta * speed

	if (progress_ratio == 1):
		queue_free()
