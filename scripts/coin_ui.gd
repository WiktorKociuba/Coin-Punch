extends Control


func _ready() -> void:
	EventController.connect("redCoinCollected", onRedCoinCollected)
	EventController.connect("silverCoinCollected", onSilverCoinCollected)
	EventController.connect("goldCoinCollected", onGoldCoinCollected)

func onRedCoinCollected(value: int) -> void:
	$Red/Label.text = str(value)

func onSilverCoinCollected(value: int) -> void:
	$Silver/Label.text = str(value)

func onGoldCoinCollected(value: int) -> void:
	$Gold/Label.text = str(value)
