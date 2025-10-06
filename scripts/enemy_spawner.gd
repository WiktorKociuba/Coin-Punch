extends Node2D

@export var enemyScene: PackedScene

var lastTime = Time.get_unix_time_from_system()

func spawnEnemy():
	var rng = RandomNumberGenerator.new()
	var angle = rng.randf_range(0,TAU)
	var distance = rng.randf_range(0, $Area2D/CollisionShape2D.shape.radius)
	var offset = Vector2(cos(angle), sin(angle)) * distance
	var spawnPos = global_position + offset
	var enemy = enemyScene.instantiate()
	enemy.global_position = spawnPos
	get_tree().current_scene.add_child(enemy)

func _process(delta: float) -> void:
	if Time.get_unix_time_from_system() - lastTime > 10:
		spawnEnemy()
		lastTime = Time.get_unix_time_from_system()
