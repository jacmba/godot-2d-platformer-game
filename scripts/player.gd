extends CharacterBody2D

const speed = 4000
const jump_force = 250
const gravity = 600

var h_velocity
var motion: float


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")
	motion = 0
	
func _process(_delta):
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
	
	move_and_slide()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
