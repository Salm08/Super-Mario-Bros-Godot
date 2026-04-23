extends Camera2D

var screen_half_width: float
var max_camera_x: float = 0.0

func _ready() -> void:
	screen_half_width = get_viewport_rect().size.x / 2
	position_smoothing_enabled = false

func _process(delta: float) -> void:
	var mario_x = get_parent().global_position.x

	if mario_x > max_camera_x + screen_half_width:
		max_camera_x = mario_x - screen_half_width

	global_position.x = max_camera_x + screen_half_width
	
	global_position.y = get_parent().global_position.y
