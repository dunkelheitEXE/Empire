class_name Enemy extends CharacterBody2D

var move_speed := 50
var attack_damage := 10
var is_attack := false

@onready var player: CharacterBody2D = $"../Player"
@onready var sprites: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if !is_attack and player:
		detect()
	move_and_slide()

func detect():
	var pos_x = player.position.x - position.x
	var pos_y = player.position.y - position.y
	
	var pos_gen = sqrt(pos_x * pos_x + pos_y * pos_y)
	
	var max_pos = 400
	if pos_gen <= max_pos:
		sprites.play("run")
		var direction = (player.position - position).normalized()
		if direction:
			velocity = direction * move_speed
			if velocity.x <0:
				sprites.flip_h = true
			else:
				sprites.flip_h = false
	else:
		sprites.play("stand")
		velocity.x = 0
		velocity.y = 0
