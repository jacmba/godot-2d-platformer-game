extends CharacterBody2D

class_name Player

const speed = 4000
const jump_force = 250
const gravity = 600
const terminal_speed = 5000

var motion: float
var dead: bool

@export var jump_sound: AudioStream
@export var damage_sound: AudioStream
@export var die_sound: AudioStream

@onready var player: AudioStreamPlayer2D = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")
	motion = 0
	dead = false
	
func _process(_delta):
	if dead:
		return
		
	if Input.is_action_pressed("move_right"):
		motion = lerp(motion, 1.0, 0.1)
	elif Input.is_action_pressed("move_left"):
		motion = lerp(motion, -1.0, 0.1)
	else:
		motion = lerp(motion, 0.0, 0.1)
		
	if abs(motion) > 0.1:
		$Sprite2D.flip_h = motion > 0
		$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):	
	velocity.x = motion * speed * delta
	velocity.y += delta * gravity
	
	velocity.y = clamp(velocity.y, -10000, terminal_speed)
	
	move_and_slide()
	
	if not dead and Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
		player.stream = jump_sound
		player.play()
		
func _on_dead():
	die()
	
func _on_dead_zone_entered():
	die()
	
func die():
	dead = true
	motion = 0
	remove_child($CollisionShape2D)
	velocity.y = -jump_force * 1.5
	player.stream = die_sound
	player.play()
	$AnimationPlayer.play("die")
	
func _on_damaged(_damage, pos):
	velocity.y = -jump_force
	motion = pos * 3
	$AnimationPlayer.play("idle")
	player.stream = damage_sound
	player.play()
