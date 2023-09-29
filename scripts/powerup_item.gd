extends Node2D

class_name PowerupItem

@export var power: int = 1
@export var force_sprite: Texture = null

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Sprite2D/Area2D
@onready var player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _init():
	if force_sprite != null:
		sprite.texture = force_sprite
		
func _on_powerup_collected(_foo):
	area.set_process(false)
	anim.play("powerup")
	get_tree().call_group("powerup_listeners", "_on_powerup", power)
	player.play()
	await anim.animation_finished
	queue_free()
