class_name Boss extends CharacterBody2D

@export var speed = 200
@export var navAgent: NavigationAgent2D
@onready var pathArea: Rect2 = $WalkPath/WalkArea/CollisionShape2D.shape.get_rect()
@export var redCoins = 20
@export var silverCoins = 20
@export var goldCoins = 20
@export var health = 30
@export var knockbackPower = 3000
@export var knockbackDuration = 0.25

var knockbackVelocity: Vector2 = Vector2.ZERO
var knockbackTimeLeft: float = 0.0
var ifHit = false
var targetNode = null
var homePos = Vector2.ZERO
var targetPos = Vector2.ZERO
var lastChangedPos = Time.get_unix_time_from_system()

func _ready():
	homePos = self.global_position
	navAgent.path_desired_distance = 4
	navAgent.target_desired_distance = 4


func _physics_process(_delta: float):
	if knockbackTimeLeft > 0.0:
		knockbackTimeLeft = max(knockbackTimeLeft - _delta, 0.0)
		knockbackVelocity = knockbackVelocity.move_toward(Vector2.ZERO, _delta)
		velocity = knockbackVelocity
		move_and_slide()
		if knockbackTimeLeft == 0.0:
			ifHit = false
			knockbackVelocity = Vector2.ZERO
			navAgent.set_velocity(Vector2.ZERO)
			recalcPath()
		return
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
	if knockbackTimeLeft > 0.0:
		return
	velocity = safe_velocity
	move_and_slide()

func onHit(value: int, playerVelocity: Vector2, playerPosition: Vector2):
	health -= value
	var knockbackDirection = (global_position - playerPosition)
	if knockbackDirection.is_zero_approx():
		knockbackDirection = -(playerVelocity)
	if knockbackDirection.is_zero_approx():
		knockbackDirection = Vector2.RIGHT
	knockbackDirection = knockbackDirection.normalized()
	knockbackVelocity = knockbackDirection * knockbackPower
	knockbackTimeLeft = knockbackDuration
	ifHit = true
	navAgent.set_velocity(Vector2.ZERO)
	navAgent.set_target_position(global_position)
	if health <= 0:
		self.queue_free()
		var rng = RandomNumberGenerator.new()
		var coinType = rng.randi_range(0,2)
		var coinQuant = rng.randi_range(1,400)
		if coinType == 0:
			goldCoins += coinQuant
		elif coinType == 1:
			redCoins += coinQuant
		else:
			silverCoins += coinQuant
		GameController.goldCoinCollected(goldCoins)
		GameController.redCoinCollected(redCoins)
		GameController.silverCoinCollected(silverCoins)
		EventController.emit_signal("unblockEntrance")
