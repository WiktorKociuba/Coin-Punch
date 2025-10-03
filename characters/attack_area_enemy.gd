extends Area2D

@export var strength: int = 1

var target = null
@onready var lastHit = Time.get_unix_time_from_system()

func _process(delta: float) -> void:
	if target != null and Time.get_unix_time_from_system() - lastHit >= 1.5:
		target.hit(strength)
		lastHit = Time.get_unix_time_from_system()

func _on_body_entered(body: Node2D) -> void:
	if target == null:
		if body is Player:
			target = body


func _on_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
