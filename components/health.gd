class_name HealthComponent extends Node2D

signal death

@export var progress_var: ProgressBar
@export var current_health := 100
@export var max_health := 100

func _ready() -> void:
	_update_health()

func _update_health():
	if progress_var:
		progress_var.value = current_health

func get_damage(amount: int):
	current_health = clamp(current_health - amount, 0, max_health)
	_update_health()
	var sonido = AudioStreamPlayer.new()
	sonido.stream = preload("res://sonidos/video-game-hit-noise-001-135821.mp3")
	add_child(sonido)
	sonido.play()
	
	if current_health == 0:
		on_death()

func on_death():
	death.emit()

func apply_health(amount: int):
	current_health = clamp(current_health + amount, 0, max_health)
	_update_health()
