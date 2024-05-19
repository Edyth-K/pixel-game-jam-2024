extends Node
@onready var game = $".."
# TODO: unpause
func _input(event):
	if event.is_action("pause"):
		if game.game_paused == true:
			game.game_paused = false
			game.get_tree().paused = false
			

