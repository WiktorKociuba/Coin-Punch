extends Control

@onready var bossDD = $BoxContainer/VBoxContainer/HBoxContainer/BossDD
var selectedBoss = -1
var bossList = [["Jeff",10,10,10],["John",20,30,40],["Placeholder",200,222,234]]

func _ready() -> void:
	EventController.connect("showBossUi",showUi)

func _process(delta: float) -> void:
	if Input.is_action_pressed("exit"):
		visible = false
		set_process_mode(Node.PROCESS_MODE_DISABLED)

func showUi():
	visible = true
	set_process_mode(Node.PROCESS_MODE_ALWAYS)

func _on_boss_dd_item_selected(index: int) -> void:
	selectedBoss = index

func _on_confirm_pb_pressed() -> void:
	if selectedBoss >= 0 and bossList[selectedBoss][1] <= GameController.redTotalCoins and bossList[selectedBoss][2] <= GameController.goldTotalCoins and bossList[selectedBoss][3] <= GameController.silverTotalCoins:
		GameController.redTotalCoins -= bossList[selectedBoss][1]
		GameController.goldTotalCoins -= bossList[selectedBoss][2]
		GameController.silverTotalCoins -= bossList[selectedBoss][3]
		EventController.emit_signal("blockEntrance")
		
