extends CharacterBody2D
signal hit
@export var speed = 100
@export var jump_force = 300
var screen_size
const GRAVITY = 730.0
func _ready() -> void:
	screen_size = get_viewport_rect().size
func _physics_process(delta: float) -> void:
	var input_velocity = Vector2.ZERO
	if Input.is_action_pressed("Left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("Right"):
		input_velocity.x += 1

	# Gravità solo quando in aria
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_force

	if input_velocity.length() > 0:
		self.velocity.x = input_velocity.normalized().x * speed
		$AnimatedSprite2D.play()
	else:
		self.velocity.x = 0
		$AnimatedSprite2D.stop()
	move_and_slide()  # gestisce collisioni e movimento
	_check_stomp()
	if not is_on_floor():
		$AnimatedSprite2D.animation = "jump"
		$AnimatedSprite2D.play()
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walkRight"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "still"
func _check_stomp() -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		# Controlla che sia un Goomba e che il player cada dall'alto
		if collider.has_method("get_stomped") and velocity.y > 0:
			# Il punto di collisione deve essere sulla testa del goomba
			# (normale verso l'alto = player sopra)
			if collision.get_normal().y < -0.5:
				collider.get_stomped()
				velocity.y = -300.0  # rimbalzino dopo il salto
