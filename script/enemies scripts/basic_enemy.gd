extends CharacterBody2D

@export var enemy_stats : Stats = load("res://resources/enemies resources/basic_enemies_stats.tres")
var health = enemy_stats.hp

@export var drops : Array[PackedScene] = [
	preload("res://scenes/power ups/ally_ship_powerup.tscn"),
	preload("res://scenes/power ups/increase_bulletspeed_powerup.tscn"),
	preload("res://scenes/power ups/muzzle_up_powerup.tscn"),
	preload("res://scenes/power ups/heal_powerup.tscn")
]
@export var drop_chance: Array[float] = [
	0.1,
	0.1,
	0.1,
	0.01
]

func _ready():
	$AnimatedSprite2D.play()

#Take damage from bullet, if health =< 0 despawn
func take_damage(damage):
	health -= damage
	
	if health <= 0:
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.animation = "death"

func _fix_item_drop_array():
	if drop_chance.size() < drops.size():
		drop_chance.resize(drops.size())
	elif drops.size() < drop_chance.size():
		drops.resize(drop_chance.size())

func _drop_power_up():
	var rand: float = randf_range(0.0, 3.0)
	
	var update_drop_value: float = 0.0
	
	for i in drop_chance.size():
		update_drop_value += drop_chance[i]
		if rand <= update_drop_value:
			if drops[i] == null:
				return
			
			var drop = drops[i].instantiate()
			drop.global_position = global_position
			get_tree().current_scene.call_deferred("add_child", drop)
			break


func _on_animated_sprite_2d_animation_finished():
	if drops.size() > 0:
		_fix_item_drop_array()
		_drop_power_up()
	Global.score += 20
	queue_free()


func _on_area_2d_body_entered(body):
	print('hit player')
	
	if body.has_method("take_damage"):
		body.take_damage(5)
