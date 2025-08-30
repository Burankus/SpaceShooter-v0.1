extends ParallaxBackground

@export var base_scroll_speed: float = 50.0
@export var sync_with_player: bool = false
@onready var player = null

func _process(delta: float) -> void:
	var scroll_speed = base_scroll_speed
	if sync_with_player and player != null:
		var player_velocity = player.velocity.y if "velocity" in player else 0.0
		scroll_speed += player_velocity * 0.5  # Reverse the effect for downward scrolling
	scroll_offset.y += scroll_speed * delta  # Change -= to += for top-to-bottom
