extends Node

func _on_trigger_entered(_trigger):
	get_tree().call_group("death_listeners", "_on_dead")
