class_name Enemy
extends CharacterBody2D

var move_speed := 50
var attack_damage := 10
var is_attack := false
var in_range_attack := false

@onready var player: Player = $"../Player"
@onready var sprites: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: HealthComponent = $Components/Health

func _ready() -> void:
	health.death.connect(die)
	if player:
		player.attack_finished.connect(verify_getting_damage)
	

func _physics_process(delta: float) -> void:
	if player:
		detect()
	
	if is_attack:
		sprites.play("attack")
		velocity = Vector2.ZERO
	
	move_and_slide()

func verify_getting_damage():
	if in_range_attack:
		health.get_damage(30)

func die():
	print("Enemigo eliminado")
	queue_free()

func detect():
	var pos_x = player.position.x - position.x
	var pos_y = player.position.y - position.y
	var pos_gen = sqrt(pos_x * pos_x + pos_y * pos_y)
	
	var max_pos = 400
	if pos_gen <= max_pos and !is_attack:
		sprites.play("run")
		var direction = (player.position - position).normalized()
		velocity = direction * move_speed
		
		sprites.flip_h = velocity.x < 0
		$AttackArea.scale.x = -1 if velocity.x < 0 else 1
	else:
		if !is_attack:
			sprites.play("stand")
			velocity = Vector2.ZERO

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body == player:
		is_attack = true


func _on_attack_area_body_exited(body: Node2D) -> void:
	if body == player:
		is_attack = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprites.animation == "attack":
		player.health.get_damage(10)
