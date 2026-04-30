extends Node

var tempo

@export var EnemyGoomba_scene: PackedScene
var score
#func _ready() -> void:
#	$TimerDiGioco.start()


func _process(delta: float) -> void:
	pass


func _on_timer_di_gioco_timeout() -> void:
	tempo += 1
