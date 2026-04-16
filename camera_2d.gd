extends Camera2D

var screen_half_width: float
var max_camera_x: float = 0.0  # la camera non torna mai indietro

func _ready() -> void:
	screen_half_width = get_viewport_rect().size.x / 2
	# Posizione iniziale: la camera non si muove finché Mario non supera il centro
	position_smoothing_enabled = false

func _process(delta: float) -> void:
	# La posizione globale di Mario è quella del parent (CharacterBody2D)
	var mario_x = get_parent().global_position.x

	# La camera si muove solo se Mario supera la metà destra dello schermo
	if mario_x > max_camera_x + screen_half_width:
		max_camera_x = mario_x - screen_half_width

	# La camera non torna mai indietro (come NES)
	global_position.x = max_camera_x + screen_half_width
	
	# Segue Mario sull'asse Y se vuoi (puoi commentare per tenerla fissa)
	global_position.y = get_parent().global_position.y
