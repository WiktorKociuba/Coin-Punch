extends Control

@onready var rng = RandomNumberGenerator.new()
var RedBet = 0
var GoldBet = 0
var SilverBet = 0
var HeadsOrTails = 0

func _on_heads_bt_pressed() -> void:
	HeadsOrTails = 0
	var generate = rng.randi_range(0,1)
	if generate == HeadsOrTails:
		GameController.goldCoinCollected(GoldBet*2)
		GameController.redCoinCollected(RedBet*2)
		GameController.silverCoinCollected(SilverBet*2)
	else:
		GameController.goldCoinCollected(-GoldBet)
		GameController.redCoinCollected(-RedBet)
		GameController.silverCoinCollected(-SilverBet)
	$BoxContainer/CenterContainer/VBoxContainer/CenterContainer/Label.text = str(generate)

func _on_tails_bt_pressed() -> void:
	HeadsOrTails = 1
	var generate = rng.randi_range(0,1)
	if generate == HeadsOrTails:
		GameController.goldCoinCollected(GoldBet*2)
		GameController.redCoinCollected(RedBet*2)
		GameController.silverCoinCollected(SilverBet*2)
	else:
		GameController.goldCoinCollected(-GoldBet)
		GameController.redCoinCollected(-RedBet)
		GameController.silverCoinCollected(-SilverBet)
	$BoxContainer/CenterContainer/VBoxContainer/CenterContainer/Label.text = str(generate)


func _on_red_input_text_changed(new_text: String) -> void:
	pass # Replace with function body.


func _on_gold_input_text_changed(new_text: String) -> void:
	pass # Replace with function body.


func _on_silver_input_text_changed(new_text: String) -> void:
	pass # Replace with function body.
