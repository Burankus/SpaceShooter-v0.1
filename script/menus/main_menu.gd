extends Node2D

func _ready():
	$BGM.play()

func _on_single_player_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	get_tree().change_scene_to_file("res://scenes/levels/main_scene.tscn")


func _on_coop_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	print("2 Player")


func _on_quit_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	get_tree().quit()
