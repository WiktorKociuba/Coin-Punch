class_name Enemy extends CharacterBody2D

@export var speed = 30
@export var navAgent: NavigationAgent2D
@onready var pathArea: Rect2 = $WalkPath/WalkArea/CollisionShape2D.shape.get_rect()
@export var redCoins = 0
@export var silverCoins = 0
@export var goldCoins = 0
@export var health = 3

var targetNode = null
var homePos = Vector2.ZERO
var targetPos = Vector2.ZERO
var lastChangedPos = Time.get_unix_time_from_system()

func _ready():
	homePos = self.global_position
	navAgent.path_desired_distance = 4
	navAgent.target_desired_distance = 4


func _physics_process(_delta: float):
	if navAgent.is_navigation_finished():
		return
	var axis = to_local(navAgent.get_next_path_position()).normalized()
	var intendedVelocity = axis * speed
	navAgent.set_velocity(intendedVelocity)

func recalcPath():
	if targetNode:
		targetPos = Vector2.ZERO
		navAgent.target_position = targetNode.global_position
	else:
		if Time.get_unix_time_from_system() - lastChangedPos > 10:
			targetPos = Vector2.ZERO
			lastChangedPos = Time.get_unix_time_from_system()
		if targetPos == Vector2.ZERO:
			targetPos = self.global_position + Vector2(randi_range(pathArea.position.x,pathArea.position.x+pathArea.size.x),randi_range(pathArea.position.y,pathArea.position.y+pathArea.size.y))
		navAgent.target_position = targetPos


func _on_recalculate_timer_timeout() -> void:
	recalcPath()


func _on_aggro_range_area_entered(area: Area2D) -> void:
	targetNode = area.owner


func _on_de_aggro_range_area_exited(area: Area2D) -> void:
	if area.owner == targetNode:
		targetNode = null


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()

func onHit(value: int):
	health -= value
	if health <= 0:
		self.queue_free()
		GameController.goldCoinCollected(goldCoins)
		GameController.redCoinCollected(redCoins)
		GameController.silverCoinCollected(silverCoins)
