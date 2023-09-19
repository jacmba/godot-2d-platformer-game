extends CharacterBody2D

@export var speed = 400
@export var jump_force = 400
@export var gravity = 200

var h_velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = Input.get_axis("ui_left", "ui_right") * speed
	
	if abs(velocity.x) > 0:
		$Sprite2D.flip_h = velocity.x > 0
	
	velocity.y += delta * gravity
	
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -jump_force
