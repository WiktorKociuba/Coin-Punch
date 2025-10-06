extends AnimatedSprite2D


func _on_jeff_play_attack() -> void:
	play("attack")


func _on_jeff_play_death() -> void:
	play("death")


func _on_jeff_play_hurt() -> void:
	play("hurt")


func _on_jeff_play_idle() -> void:
	play("idle")


func _on_jeff_play_walk() -> void:
	play("walk")
