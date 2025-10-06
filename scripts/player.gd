class_name Player extends CharacterBody2D

@export var knockbackPower = 2000
@onready var attackArea = $AttackArea
@onready var lastRestore = Time.get_unix_time_from_system()

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const maxHealth = 5
var currentHealth = 5
enum AnimationState {ATTACK,DEATH,HURT,IDLE,WALK}
var curState = AnimationState.IDLE

func _process(delta: float) -> void:
	if Time.get_unix_time_from_system() - lastRestore >= 20.0 and currentHealth < maxHealth:
		currentHealth += 1
		lastRestore = Time.get_unix_time_from_system()
	for i in range(maxHealth):
		var heart = $HealthUI/HealthBar.get_child(i)
		if i < currentHealth:
			heart.visible = true
		else:
			heart.visible = false

func _physics_process(delta: float) -> void:
	var directionX := Input.get_axis("left", "right")
	if directionX:
		velocity.x = directionX * SPEED
		if velocity.x > 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var directionY := Input.get_axis("up","down")
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if curState == AnimationState.HURT or curState == AnimationState.DEATH or curState == AnimationState.ATTACK:
		move_and_slide()
		return
	if velocity != Vector2.ZERO:
		curState = AnimationState.WALK
		$AnimatedSprite2D.play("walk")
	else:
		curState = AnimationState.IDLE
		$AnimatedSprite2D.play("idle")

	move_and_slide()

func hit(value: int, enemyVelocity: Vector2):
	currentHealth -= value
	$AnimatedSprite2D.play("hurt")
	curState = AnimationState.HURT
	if currentHealth <= 0:
		$AnimatedSprite2D.play("death")
		curState = AnimationState.DEATH
		get_tree().paused = true
		$DeathUI.visible = true
	var knockbackDirection = (enemyVelocity-velocity).normalized()*knockbackPower
	velocity = knockbackDirection
	print(enemyVelocity)
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if curState == AnimationState.HURT:
		curState = AnimationState.WALK
		$AnimatedSprite2D.play("walk")
	if curState == AnimationState.ATTACK:
		curState = AnimationState.WALK
		$AnimatedSprite2D.play("walk")
	if curState == AnimationState.DEATH:
		get_tree().paused = true
		$DeathUI.visible = true


func _on_attack_area_enemy_attacked() -> void:
	curState = AnimationState.ATTACK
	$AnimatedSprite2D.play("attack")
