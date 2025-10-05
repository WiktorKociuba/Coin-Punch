extends Control

@export var player : Player
@onready var bossDD = $BoxContainer/VBoxContainer/HBoxContainer/BossDD
var selectedBoss = -1
var bossList = [["Jeff",100,100,100],["Placeholder",400,422,234]]
var jeff:= preload("res://characters/jeff.tscn")
var placeholder:= preload("res://characters/placeholder.tscn")

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
		if selectedBoss == 0:
			var boss = jeff.instantiate() as CharacterBody2D
			boss.global_position = Vector2(2017,-2469)
			get_tree().current_scene.add_child(boss)
			player.global_position = Vector2(1686,-2730)
		elif selectedBoss == 1:
			var boss = placeholder.instantiate() as CharacterBody2D
			boss.global_position = Vector2(2017,-2469)
			get_tree().current_scene.add_child(boss)
			player.global_position = Vector2(1686,-2730)
		visible = false
		set_process_mode(Node.PROCESS_MODE_DISABLED)
