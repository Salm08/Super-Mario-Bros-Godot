extends CharacterBody2D

signal hit

@export var speed = 100
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var input_velocity = Vector2.ZERO

	if Input.is_action_pressed("Left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("Right"):
		input_velocity.x += 1
	if Input.is_action_pressed("Up"):
		input_velocity.y -= 1
	

	if input_velocity.length() > 0:
		self.velocity = input_velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		self.velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()

	move_and_slide()  # ← gestisce collisioni e movimento

	# Clamp manuale della posizione (opzionale con move_and_slide)
	#position = position.clamp(Vector2.ZERO, screen_size)

	# Animazioni
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walkRight"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "walkRight"  # o un'animazione verticale
	else:
		$AnimatedSprite2D.animation = "still"
