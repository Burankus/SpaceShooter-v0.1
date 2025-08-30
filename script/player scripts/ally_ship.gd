extends CharacterBody2D

var Bullet = preload("res://scenes/projectiles/Bullet.tscn")

@onready var muzzle = $Muzzle

func shoot():
	$AudioStreamPlayer2D.play()
	var bullet = Bullet.instantiate()
	bullet.position = muzzle.global_position
	get_tree().current_scene.add_child(bullet)

func _on_timer_timeout():
	shoot()
