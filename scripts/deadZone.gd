extends Area2D

func _on_zone_entered(_body):
	get_tree().call_group("dead_zone_listeners", "_on_dead_zone_entered")
