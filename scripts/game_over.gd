extends Control

class_name GameOver

func _input(event):
	if event is InputEventKey and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/world/menu.tscn")
