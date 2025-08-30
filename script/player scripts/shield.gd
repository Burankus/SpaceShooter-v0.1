extends Area2D

func _ready():
	$AnimatedSprite2D.play()

func _on_body_entered(body):
	queue_free()
	Global.have_shield = false
	

func _on_area_entered(area):
	queue_free()
	Global.have_shield = false
