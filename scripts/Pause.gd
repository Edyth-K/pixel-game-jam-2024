extends Node
@onready var game = $".."
# TODO: unpause
func _input(event):
	if event.is_action("pause"):
		print("pause")
		if game.game_paused == true:
			print("work")
			game.game_paused = false
			game.get_tree().paused = false
			

