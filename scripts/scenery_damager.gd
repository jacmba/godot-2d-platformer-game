extends Node2D

class_name  SceneryDamager

@export var damage = 2

func _on_trigger_entered(trigger):
	var direction = 1
	if trigger.position.x < position.x:
		direction = -1
	get_tree().call_group("damage_listeners", "_on_damaged", damage, direction)
