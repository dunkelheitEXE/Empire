class_name Fire extends Node2D

var damage := 10
@onready var player: Player = $"../Player"

func _ready() -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		player.health.get_damage(damage)
		var sonido = AudioStreamPlayer.new()
		sonido.stream = preload("res://sonidos/explosion-3-386885.mp3")
		add_child(sonido)
		sonido.play()
