extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	value = max_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_hp_change(health, change):
	print(health)
	if not change:
		while value > health:
			value -= 1
			await get_tree().create_timer(0.02).timeout
