extends Camera2D

@export var player: CharacterBody2D

var max_x := 0.0

func _ready():
	max_x = global_position.x

func _process(delta):
	if player == null:
		return

	var half_screen = get_viewport_rect().size.x / 2

	# quando il player supera metà schermo
	var desired_x = player.global_position.x - half_screen

	# la camera NON torna indietro
	if desired_x > max_x:
		max_x = desired_x

	global_position.x = max_x
