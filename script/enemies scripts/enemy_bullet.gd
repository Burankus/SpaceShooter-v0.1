extends Area2D

@export var bullet_stats : BulletStats = load("res://resources/enemies resources/enemy_bullet_stats.tres")
var speed = bullet_stats.speed;
var damage = bullet_stats.damage
var bullet_range = bullet_stats.bullet_range
var distance_travelled = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	distance_travelled += delta * speed
	if distance_travelled > bullet_range:
		queue_free()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()

func _on_area_entered(area):
	queue_free()
