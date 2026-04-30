extends CharacterBody2D

@export var speed: float = 60.0
var direction: float = -1.0  # -1 = sinistra, 1 = destra

func _physics_process(delta: float) -> void:
	# Gravità
	if not is_on_floor():
		velocity.y += 980 * delta

	# Movimento orizzontale
	velocity.x = direction * speed

	move_and_slide()

	# Inverti direzione se tocca un muro
	if is_on_wall():
		direction *= -1

	# Animazione
	$AnimatedSprite2D.play("walk")
	$AnimatedSprite2D.flip_h = direction > 0
