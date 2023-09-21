extends Control

const first_stage = "res://scenes/world/stage1.tscn"

func _on_start_button_pressed():
	get_tree().change_scene_to_file(first_stage)
	
func _on_exit_button_pressed():
	get_tree().quit()
