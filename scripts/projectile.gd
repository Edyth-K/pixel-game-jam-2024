extends Area2D

const SPEED = 30
var travel_distance = 0 # destroy bullet after it's travelled enough
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	const RANGE = 60
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travel_distance += SPEED * delta
	if travel_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free() # destroy bullet when it collides
	if body.has_method("take_damage"):
		body.take_damage()
