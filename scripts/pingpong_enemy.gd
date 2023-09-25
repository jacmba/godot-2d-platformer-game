extends CharacterBody2D

enum EnemyStatus {
	IDLE,
	WALKING,
	DYING
}

enum Direction {
	LEFT = -1,
	RIGHT = 1
}

@export var speed = 2000

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var ray: = $RayCast2D
@onready var playerDetector: Area2D = $PlayerDetector
@onready var wallDetector: Area2D = $WallDetector

var direction: Direction = Direction.LEFT
var status: EnemyStatus = EnemyStatus.WALKING

func _physics_process(delta):
	if status == EnemyStatus.WALKING:
		if not ray.is_colliding():
			change_dir()
		velocity.x = speed * delta * direction
		
		move_and_slide()
	
func _on_change_dir(_body):
	change_dir()
	
func _on_player_detected(body):
	if status == EnemyStatus.DYING:
		return
		
	var player: CharacterBody2D = body as CharacterBody2D
	if player.velocity.y > 0:
		status = EnemyStatus.DYING
		anim.play("die")
		player.velocity.y = -200
		remove_child(playerDetector)
		remove_child(wallDetector)
		var t = Timer.new()
		t.wait_time = 2
		add_child(t)
		t.start()
		await t.timeout
		queue_free()
	else:
		get_tree().call_group("death_listeners", "_on_dead")
	
func change_dir():
	scale.x *= -1
	direction *= -1
