extends Node2D

@onready var hud = $UI/MainMenuUI/Label

func _ready():
	$Death.play()
	$BGM.play()
	hud.text = "Score: " + str(Global.score)

func _on_retry_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	get_tree().change_scene_to_file("res://scenes/levels/main_scene.tscn")


func _on_quit_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	get_tree().quit()
