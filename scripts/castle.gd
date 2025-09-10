class_name Castle extends Node2D
@onready var player: Player = $"../Player"
func _ready() -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		print("GANADOR")
		get_tree().change_scene_to_file("res://scenes/world_2.tscn")
