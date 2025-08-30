extends Area2D

@export var bullet_stats : BulletStats = load("res://resources/player resources/default_gun_stats.tres")
var speed = bullet_stats.speed;
var damage = bullet_stats.damage
var bullet_range = bullet_stats.bullet_range
var distance_travelled = 0

func _physics_process(delta):
	fire_bullet(delta)

#Move bullet, if bullet too far despawn
func fire_bullet(delta):
	position.y -= delta * speed
	
	distance_travelled += delta * speed
	if distance_travelled > bullet_range:
		queue_free()

#Collide with enemy
func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
