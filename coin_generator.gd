extends Node2D

var rng = RandomNumberGenerator.new()
var redCoin:= preload("res://collectibles/red_coin.tscn")
var goldCoin:= preload("res://collectibles/gold_coin.tscn")
var silverCoin:= preload("res://collectibles/silver_coin.tscn")

func _ready() -> void:
	rng.randomize()

func _on_spawn_timer_timeout() -> void:
	var rectNode := $Area2D/CollisionShape2D as CollisionShape2D
	var rect := rectNode.shape
	var x := rng.randf_range(-rect.extents.x, rect.extents.x)
	var y := rng.randf_range(-rect.extents.y, rect.extents.y)
	var coinNumber = rng.randi_range(0,2)
	var pos = $Area2D.to_global(Vector2(x,y))
	if coinNumber == 0:
		var coin = redCoin.instantiate() as Node2D
		coin.global_position = pos
		get_tree().current_scene.add_child(coin)
	elif coinNumber == 1:
		var coin = goldCoin.instantiate() as Node2D
		coin.global_position = pos
		get_tree().current_scene.add_child(coin)
	if coinNumber == 2:
		var coin = silverCoin.instantiate() as Node2D
		coin.global_position = pos
		get_tree().current_scene.add_child(coin)
	$SpawnTimer.wait_time = rng.randf_range(0.5,5.0)
	print("here")
