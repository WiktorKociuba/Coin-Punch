extends Node

@onready var goldTotalCoins: int = 0
@onready var silverTotalCoins: int = 0
@onready var redTotalCoins: int = 0

func goldCoinCollected(value: int):
	goldTotalCoins += value
	EventController.emit_signal("goldCoinCollected", goldTotalCoins)

func silverCoinCollected(value: int):
	silverTotalCoins += value
	EventController.emit_signal("silverCoinCollected", silverTotalCoins)

func redCoinCollected(value: int):
	redTotalCoins += value
	EventController.emit_signal("redCoinCollected", redTotalCoins)
