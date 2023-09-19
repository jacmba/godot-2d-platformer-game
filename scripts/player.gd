extends RigidBody2D

@export var speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var h_velocity = 0
	h_velocity = Input.get_axis("ui_left", "ui_right")
	position.x += h_velocity * speed * delta
