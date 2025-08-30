extends CharacterBody2D

signal game_over

#Stats sheets using resource
@export var stats : Stats = load("res://resources/player resources/player_stats.tres")

var health = stats.hp

var atk_speed_lvl = 1
var muzzle_lvl = 1
var ally_count = 0

#Load bullet
var Bullet = preload("res://scenes/projectiles/Bullet.tscn")
var can_shoot = true

var AllyShip = preload("res://scenes/player/ally_ship.tscn")
var Shield = preload("res://scenes/player/shield.tscn")

#Get place to spawn bullet
@onready var muzzle = $Muzzle
@onready var muzzle2 = $Muzzle2
@onready var muzzle3 = $Muzzle3

@onready var ally_spawn = $AllyshipSpawn1
@onready var ally_spawn2 = $AllyshipSpawn2

@onready var shield_pos = $ShieldSpawn

func _physics_process(delta):
	player_movement(delta)
	
func _process(_delta):
	if can_shoot && Input.get_action_strength("shoot"):
		if muzzle_lvl == 1:
			shoot()
		elif muzzle_lvl == 2:
			shoot2()
			shoot3()
		elif muzzle_lvl == 3:
			shoot()
			shoot2()
			shoot3()

#Movement script
func player_movement(delta):
	$BoosterSprite.play()
	var input_vector = Vector2.ZERO
	
	#Different movement speed
	var slow_speed = stats.speed / 4
	var half_speed = stats.speed / 2
	var full_speed = stats.speed
	
	var acceleration = 3000
	var deceleration = 3000
	
	#Getting input from both keyboard and controller
	#If is controller => Get movement strength of the joystick from 0 -> 1
	var up_strength = Input.get_action_strength("move_up")
	var down_strength = Input.get_action_strength("move_down")
	var right_strength = Input.get_action_strength("move_right")
	var left_strength = Input.get_action_strength("move_left")
	
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	#Normalized the vector so that diagonal movement have the same speed as 1 direction movement
	input_vector.normalized()
	
	#Movement script with controller joystick strength
	if input_vector != Vector2.ZERO:
		#print(velocity)
		if (up_strength < 0.25 && down_strength < 0.25 && right_strength < 0.25 && left_strength < 0.25):
			velocity = velocity.move_toward(input_vector * slow_speed, acceleration * delta)
		elif (up_strength < 0.65 && down_strength < 0.65 && right_strength < 0.65 && left_strength < 0.65):
			velocity = velocity.move_toward(input_vector * half_speed, acceleration * delta)
		else:
			velocity = velocity.move_toward(input_vector * full_speed, acceleration * delta)
		##Changing sprites to show left and right
		if velocity.x < 0:
			$AnimatedSprite2D.animation = "left"
		elif velocity.x > 0:
			$AnimatedSprite2D.animation = "right"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
		$AnimatedSprite2D.animation = "default"
	
	#Move the character
	move_and_collide(velocity * delta)
	
	#Limit the area of that the player can access
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)

#Shoot script
func shoot():
	$Laser.play()
	#Innitialize bullet object, set spawn pos, spawn bullet
	var bullet = Bullet.instantiate()
	bullet.position = muzzle.global_position
	get_tree().current_scene.add_child(bullet)
	
	#Start the timer for bullet delay
	$Bullet_Speed.start()
	can_shoot = false

func shoot2():
	$Laser.play()
	
	#Innitialize bullet object, set spawn pos, spawn bullet
	var bullet = Bullet.instantiate()
	bullet.position = muzzle2.global_position
	get_tree().current_scene.add_child(bullet)
	
	#Start the timer for bullet delay
	$Bullet_Speed.start()
	can_shoot = false
	
func shoot3():
	$Laser.play()
	
	#Innitialize bullet object, set spawn pos, spawn bullet
	var bullet = Bullet.instantiate()
	bullet.position = muzzle3.global_position
	get_tree().current_scene.add_child(bullet)
	
	#Start the timer for bullet delay
	$Bullet_Speed.start()
	can_shoot = false

func take_damage(damage):
	$Hit.play()
	health -= damage
	
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/menus/game_over.tscn")
		game_over.emit()

#Timer for next bullet
func _on_bullet_speed_timeout():
	can_shoot = true

#Power ups
#Increase attack speed
func increase_bulletspeed_pu():
	$PowerUpCollected.play()
	$Powerup.play()
	if atk_speed_lvl == 1:
		atk_speed_lvl += 1
		update_atk_speed()
	elif atk_speed_lvl == 2:
		atk_speed_lvl += 1
		update_atk_speed()
	elif atk_speed_lvl == 3:
		atk_speed_lvl += 1
		update_atk_speed()
	elif atk_speed_lvl == 4:
		atk_speed_lvl += 1
		update_atk_speed()
	elif atk_speed_lvl == 5:
		update_atk_speed()

func update_atk_speed():
	if atk_speed_lvl == 1:
		stats.firing_speed = 0.5
	elif atk_speed_lvl == 2:
		stats.firing_speed = 0.4
	elif atk_speed_lvl == 3:
		stats.firing_speed = 0.3
	elif atk_speed_lvl == 4:
		stats.firing_speed = 0.2
	elif atk_speed_lvl == 5:
		stats.firing_speed = 0.1
		
	$Bullet_Speed.wait_time = stats.firing_speed

#Adding ally ships
func add_ally_ship():
	$PowerUpCollected.play()
	$Powerup.play()
	if ally_count == 0:
		ally_count += 1
		
		call_deferred("_instantiate_ally_ship", ally_spawn.position)
	elif ally_count == 1:
		ally_count += 1
		
		call_deferred("_instantiate_ally_ship", ally_spawn2.position)
	else:
		pass

# Deferred function to create the ally ship after the physics frame is done
func _instantiate_ally_ship(position: Vector2):
	var allyship = AllyShip.instantiate()
	allyship.position = position
	add_child(allyship)

#Adding muzzle
func muzzle_up_pu():
	$PowerUpCollected.play()
	$Powerup.play()
	if muzzle_lvl == 1:
		muzzle_lvl += 1
	elif muzzle_lvl == 2:
		muzzle_lvl += 1
	else:
		pass

func add_shield():
	$PowerUpCollected.play()
	$Powerup.play()
	if Global.have_shield == false:
		Global.have_shield = true
		
		call_deferred("_instantiate_shield", shield_pos.position)
	elif Global.have_shield == true:
		pass

func _instantiate_shield(position: Vector2):
	var shield = Shield.instantiate()
	shield.position = position
	add_child(shield)

func heal():
	$PowerUpCollected.play()
	$Powerup.play()
	if health < 50 && health > 45:
		health += (50 - health)
	elif health < 50:
		health += 5
	else:
		pass
