class_name Player extends CharacterBody2D

signal attack_finished

var move_speed := 150
var damage := 50
var is_attack := false


@onready var _animation_player = $AnimatedSprite2D
@onready var health: HealthComponent = $Components/Health

func _ready() -> void:
	health.death.connect(die)

func _physics_process(delta: float) -> void:
	var move_direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_just_pressed("attack"):
		attack()
	
	if !is_attack:
		if move_direction:
			velocity = move_direction * move_speed
			_animation_player.play("run")
			$Area2D.scale.x = -1 if velocity.x <0 else 1
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

func die():
	print("game over")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_animated_sprite_2d_animation_finished() -> void:
	if _animation_player.animation == "attack":
		is_attack = false
		emit_signal("attack_finished")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.in_range_attack = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy:
		body.in_range_attack = false
