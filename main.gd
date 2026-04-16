extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CharacterBody2D.position = Vector2(8, -8)
	print("Mario position: ", $CharacterBody2D.position)
	print("Mario visible: ", $CharacterBody2D.visible)
	print("Sprite frames: ", $CharacterBody2D/AnimatedSprite2D.sprite_frames)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
