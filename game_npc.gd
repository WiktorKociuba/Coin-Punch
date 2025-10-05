class_name GameNPC extends CharacterBody2D

@export var gameToLoad: int


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("entered")
	if gameToLoad == 1:
		EventController.emit_signal("showCoinFlipUi")
