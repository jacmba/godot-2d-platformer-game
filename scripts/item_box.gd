extends Node2D

class_name ItemBox

@export var item: PackedScene = null

@onready var anim: AnimationPlayer = $AnimationPlayer

func _on_broken(body):
	if body.velocity.y < -0.1:
		anim.play("break")
		await anim.animation_finished
		if item != null:
			var item_instance = item.instantiate()
			item_instance.position = position
			get_parent().add_child(item_instance)
		queue_free()
