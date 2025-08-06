extends CharacterBody2D

var move_speed := 150
var damage := 50
var is_attack := false

@onready var _animation_player = $AnimatedSprite2D;


func _physics_process(delta: float) -> void:
	var move_direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if !is_attack:
		if move_direction:
			velocity = move_direction * move_speed
			_animation_player.play("run")
			if move_direction.x !=0:
				_animation_player.flip_h = move_direction.x < 0
		else:
			velocity.x = 0
			velocity.y = 0
			_animation_player.play("idle")
	else:
		velocity.x=0
		velocity.y = 0
	
	move_and_slide()

func attack():
	is_attack = true
	_animation_player.play("attack")

func _on_animated_sprite_2d_animation_finished() -> void:
	if _animation_player.animation == "attack":
		is_attack = false
