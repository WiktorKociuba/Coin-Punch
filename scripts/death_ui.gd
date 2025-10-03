extends Control


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	GameController.goldTotalCoins = 0
	GameController.redTotalCoins = 0
	GameController.silverTotalCoins = 0
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
