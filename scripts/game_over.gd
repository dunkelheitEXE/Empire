extends Control

@onready var button: Button = $Button

func _ready() -> void:
	pass

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
