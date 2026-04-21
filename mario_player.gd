extends CharacterBody2D
signal hit
@export var speed = 100
@export var jump_force = 350  # ← aggiunto
var screen_size
const GRAVITY = 800.0
func _ready() -> void:
	screen_size = get_viewport_rect().size
func _physics_process(delta: float) -> void:
	var input_velocity = Vector2.ZERO
	if Input.is_action_pressed("Left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("Right"):
		input_velocity.x += 1
	# ← rimosso "Up" per il movimento: in un platformer non si vola

	# ← Gravità: si applica solo quando è in aria
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# ← Salto: sovrascrive velocity.y solo al momento del press
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_force

	if input_velocity.length() > 0:
		self.velocity.x = input_velocity.normalized().x * speed  # ← solo X, non sovrascrivere Y (gravità/salto)
		$AnimatedSprite2D.play()
	else:
		self.velocity.x = 0  # ← solo X, non toccare Y
		$AnimatedSprite2D.stop()
	move_and_slide()  # ← gestisce collisioni e movimento
	# Clamp manuale della posizione (opzionale con move_and_slide)
	#position = position.clamp(Vector2.ZERO, screen_size)
	# Animazioni
	if not is_on_floor():
		$AnimatedSprite2D.animation = "jump"  # ← aggiunto stato in aria
		$AnimatedSprite2D.play()
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walkRight"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "still"
