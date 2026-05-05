extends CharacterBody2D

@export var speed: float = 60.0
var direction: float = -1.0  # -1 = sinistra, 1 = destra
var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return
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
	$AnimatedSprite2D.play("Walk")
	$AnimatedSprite2D.flip_h = direction > 0
	
func get_stomped() -> void:
	if is_dead:
		return
	is_dead = true
	velocity = Vector2.ZERO
	$CollisionShape2D.set_deferred("disabled", true)  # evita ulteriori collisioni
	$AnimatedSprite2D.play("Crushed")
	# Aspetta che l'animazione finisca poi rimuovi
	$AnimatedSprite2D.animation_finished.connect(_on_crushed_finished)

func _on_crushed_finished() -> void:
	queue_free()
