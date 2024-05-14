extends Area2D
@onready var auto_aim_weapon = $"."
@onready var projectile_spawn_point = $ProjectileSpawnPoint
@onready var in_range_label = $InRangeLabel
@onready var spray_timer = $SprayTimer

# given an array of enemies, return the closest enemy
# used for auto targetting to target closest enemy
func get_closest(enemies):
	var lowest_distance = 8192.0
	var closest
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance <= lowest_distance:
			lowest_distance = distance
			closest = enemy
	return closest
	
func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = get_closest(enemies_in_range)
		look_at(target_enemy.global_position)

func shoot():
	# load vs preload: preload is static on launch, load is on demand
	const BUBBLE = preload("res://scenes/player/attacks/bubble.tscn")
	var new_bubble = BUBBLE.instantiate()
	new_bubble.global_position = projectile_spawn_point.global_position
	new_bubble.global_rotation = projectile_spawn_point.global_rotation
	projectile_spawn_point.add_child(new_bubble)

# identical to shoot, but shoots 4 bubbles
func spray():
	shoot()
	await get_tree().create_timer(0.1).timeout
	shoot()
	await get_tree().create_timer(0.1).timeout
	shoot()

	
func _on_timer_timeout():
	spray()

