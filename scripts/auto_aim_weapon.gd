extends Area2D
@onready var auto_aim_weapon = $"."
@onready var projectile_spawn_point = $ProjectileSpawnPoint

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		print("enemy")
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot():
	# load vs preload: preload is static on launch, load is on demand
	print("shooting")
	const BUBBLE = preload("res://scenes/projectile.tscn")
	var new_bubble = BUBBLE.instantiate()
	new_bubble.global_position = projectile_spawn_point.global_position
	new_bubble.global_rotation = projectile_spawn_point.global_rotation
	projectile_spawn_point.add_child(new_bubble)



func _on_timer_timeout():
	shoot()
