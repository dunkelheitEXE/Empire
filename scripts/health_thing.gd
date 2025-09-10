class_name HealthThing extends Node2D

signal sound

var amount:= 20
@onready var player: Player = $"../Player"

func _ready() -> void:
	pass

func get_health():
	player.health.apply_health(amount)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player and player.health.current_health != 100:
		emit_signal("sound")
		get_health()
		queue_free()
