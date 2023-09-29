extends CharacterBody2D

class_name SlimeBoss

enum Direction {
	LEFT = -1,
	RIGHT = 1
}

enum Status {
	IDLE,
	JUMPING,
	CROSSING,
	DYING
}

signal boss_killed

const speed = 6000
const jump_force = 500
const gravity = 1500

@export var damage = 1
@export var health = 5
@export var squash_sound: AudioStream

@onready var statusTimer: Timer = $StatusTimer
@onready var status: Status = Status.IDLE
@onready var direction: Direction = Direction.LEFT
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var standard_material: Material = $Sprite2D.material
@onready var hit_material: Material = preload("res://materials/hit_material.tres")

func _ready():
	statusTimer.start()
	$Sprite2D.material = hit_material
	$Sprite2D.material = standard_material
	
func _physics_process(delta):
	velocity.y += gravity * delta
	
	match status:
		Status.JUMPING, Status.CROSSING:
			velocity.x = direction * speed * delta
		_:
			velocity.x = 0
			
	if status == Status.JUMPING and is_on_floor():
		_on_status_change()
			
	move_and_slide()
	
func _on_change_area_entered(_body):
	if status == Status.CROSSING:
		_on_status_change()
	
func _on_status_change():
	match status:
		Status.IDLE:
			status = Status.JUMPING
			velocity.y = -jump_force
		Status.JUMPING:
			status = Status.CROSSING
		Status.CROSSING:
			status = Status.IDLE
			direction *= -1
			scale.x *= -1
			statusTimer.start()
			
func damage_player(player: CharacterBody2D):
	var dir = 1
	if player.position.x < position.x:
		dir = -1
	get_tree().call_group("damage_listeners", "_on_damaged", damage, dir)
	
func _on_player_detected(body):
	damage_player(body as CharacterBody2D)
	
func _on_player_hit(body):
	var player: CharacterBody2D = body as CharacterBody2D
	if status == Status.CROSSING and player.position.y < position.y and player.velocity.y > 0.1:
		player.velocity.y = -200
		health -= 1
		audio_player.stream = squash_sound
		audio_player.play()
		
		if health <= 0:
			$PlayerDetector.queue_free()
			$PlayerHitZone.queue_free()
			status = Status.DYING
			anim.play("die")
			await anim.animation_finished
			boss_killed.emit()
		else:
			$Sprite2D.material = hit_material
			var t: Timer = Timer.new()
			t.wait_time = 0.5
			add_child(t)
			t.start()
			await t.timeout
			$Sprite2D.material = standard_material
			t.queue_free()
	else:
		damage_player(player)
