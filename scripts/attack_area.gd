extends Area2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack(1)

func attack(value: int):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		print("hered")
		if body is Enemy:
			print("hit")
			body.onHit(value)
