extends Marker2D

@onready var player = get_node("/root/Main Scene/Player")

func _physics_process(_delta):
	if player != null:
		look_at(player.global_position)
	else:
		pass
