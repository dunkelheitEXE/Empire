extends AudioStreamPlayer2D
@onready var health_thing: HealthThing = $"../HealthThing"

func _ready() -> void:
	health_thing.sound.connect(rep)

func rep():
	stream = preload("res://sonidos/cauldron-bubbling-2-232443.mp3")
	play()
