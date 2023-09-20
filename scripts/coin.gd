extends Sprite2D

func _on_area_2d_body_entered(_body):
	get_tree().call_group("coin_listeners", "_on_coin_collected")
	queue_free()
