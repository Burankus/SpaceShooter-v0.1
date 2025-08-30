extends Area2D

func _physics_process(delta):
	move(delta)

func move(delta):
	position.y += delta * 80

func _on_body_entered(body):
	Global.score += 10
	queue_free()
	
	if body.has_method("increase_bulletspeed_pu"):
		body.increase_bulletspeed_pu()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
