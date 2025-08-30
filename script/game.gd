extends Node2D

@onready var player_spawn_pos = $PlayerSpawnPos
@export var player1 = preload("res://scenes/player/player.tscn")

#Enemies Spawner
@onready var enemy_container = $EnemyContainer
@export var PopcornEnemies : PackedScene = preload("res://scenes/misc/enemy_path_follow.tscn")
@export var ShooterEnemies : PackedScene = preload("res://scenes/entities/shooting_enemy.tscn")
@export var BomberEnemies : PackedScene = preload("res://scenes/entities/follow_enemy.tscn")

@onready var popcorn_enemies_spawn1 = $EnemyContainer/EnemyPath1
@onready var popcorn_enemies_spawn2 = $EnemyContainer/EnemyPath2
@onready var popcorn_enemies_spawn3 = $EnemyContainer/EnemyPath3
@onready var popcorn_enemies_spawn4 = $EnemyContainer/EnemyPath4
@onready var popcorn_enemies_spawn5 = $EnemyContainer/EnemyPath5
@onready var popcorn_enemies_spawn6 = $EnemyContainer/EnemyPath6
@onready var spawn_offset_timer = $PopcornSpawnOffsetTimer

var pathCount = 2

@export var spawn_count = 0
var rng = RandomNumberGenerator.new()
var random_path = rng.randi_range(0, pathCount)

func _ready():
	$BGM.play()
	$MediumDifficulty.start()
	$HardDifficulty.start()
	$HarderDifficulty.start()
	$PopcornEnemySpawnTimer.wait_time = 8
	Global.score = 0
	var player = player1.instantiate()
	player.global_position = player_spawn_pos.global_position
	add_child(player)

func _spawn_popcorn_enemies():
	if random_path == 0:
		var new_popcorn_enemy = PopcornEnemies.instantiate()
		new_popcorn_enemy.global_position = popcorn_enemies_spawn1.global_position
		popcorn_enemies_spawn1.add_child(new_popcorn_enemy)
		spawn_count += 1
	if random_path == 1:
		var new_popcorn_enemy = PopcornEnemies.instantiate()
		new_popcorn_enemy.global_position = popcorn_enemies_spawn2.global_position
		popcorn_enemies_spawn2.add_child(new_popcorn_enemy)
		spawn_count += 1
	if random_path == 2:
		var new_popcorn_enemy = PopcornEnemies.instantiate()
		new_popcorn_enemy.global_position = popcorn_enemies_spawn3.global_position
		popcorn_enemies_spawn3.add_child(new_popcorn_enemy)
		spawn_count += 1
	if random_path == 3:
		var new_popcorn_enemy = PopcornEnemies.instantiate()
		new_popcorn_enemy.global_position = popcorn_enemies_spawn4.global_position
		popcorn_enemies_spawn4.add_child(new_popcorn_enemy)
		spawn_count += 1
	if random_path == 4:
		var new_popcorn_enemy = PopcornEnemies.instantiate()
		new_popcorn_enemy.global_position = popcorn_enemies_spawn5.global_position
		popcorn_enemies_spawn5.add_child(new_popcorn_enemy)
		spawn_count += 1
	if random_path == 5:
		var new_popcorn_enemy = PopcornEnemies.instantiate()
		new_popcorn_enemy.global_position = popcorn_enemies_spawn6.global_position
		popcorn_enemies_spawn6.add_child(new_popcorn_enemy)
		spawn_count += 1
	
	if spawn_count >= 5:
		spawn_offset_timer.stop()
		spawn_count = 0
		random_path = rng.randi_range(0, 2)

func _on_enemy_spawn_timer_timeout():
	spawn_offset_timer.start()

func _on_spawn_offset_timer_timeout():
	_spawn_popcorn_enemies()

#Change to when game over display score
#func _process(delta):
	#if Input.get_action_strength("move_down"):
		#hud.score = Global.score

func _on_shooter_enemy_spawn_timer_timeout():
	var shooter_enemy = ShooterEnemies.instantiate()
	shooter_enemy.global_position = Vector2(randf_range(50, 500), -20)
	enemy_container.add_child(shooter_enemy)

func _on_bomber_enemy_spawn_timer_timeout():
	var bomber_enemy = BomberEnemies.instantiate()
	bomber_enemy.global_position = Vector2(randf_range(50, 500), -20)
	enemy_container.add_child(bomber_enemy)

func _on_medium_difficulty_timeout():
	print("Medium")
	pathCount = 3
	random_path = rng.randi_range(0, pathCount)
	$PopcornEnemySpawnTimer.wait_time = 4
	$ShooterEnemySpawnTimer.wait_time = 10
	$BomberEnemySpawnTimer.wait_time = 5
	
func _on_hard_difficulty_timeout():
	print("Hard")
	pathCount = 4
	random_path = rng.randi_range(0, pathCount)
	$PopcornEnemySpawnTimer.wait_time = 2
	$ShooterEnemySpawnTimer.wait_time = 5
	$BomberEnemySpawnTimer.wait_time = 3

func _on_harder_difficulty_timeout():
	print("Harder")
	pathCount = 5
	random_path = rng.randi_range(0, pathCount)
	$PopcornEnemySpawnTimer.wait_time = 1
	$ShooterEnemySpawnTimer.wait_time = 3
	$BomberEnemySpawnTimer.wait_time = 2
