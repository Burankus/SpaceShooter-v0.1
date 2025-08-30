extends Area2D

func _physics_process(delta):
	move(delta)

func move(delta):
	position.y += delta * 80

func _on_body_entered(body):
	Global.score += 15
	queue_free()
	
	if body.has_method("add_ally_ship"):
		body.add_ally_ship()


func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()
