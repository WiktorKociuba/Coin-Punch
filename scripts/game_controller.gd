extends Node

@export var goldTotalCoins: int = 0
@export var silverTotalCoins: int = 0
@export var redTotalCoins: int = 0

func goldCoinCollected(value: int):
	goldTotalCoins += value
	EventController.emit_signal("goldCoinCollected")

func silverCoinCollected(value: int):
	silverTotalCoins += value
	EventController.emit_signal("silverCoinCollected")

func redCoinCollected(value: int):
	redTotalCoins += value
	EventController.emit_signal("redCoinCollected")
