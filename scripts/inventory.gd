extends Node

@export var coin_list: Node
@export var stage = 0

var coins = 0

@onready var coin_counter: Label = $CoinCounter
@onready var stage_coins = coin_list.get_child_count()

func _on_coin_collected():
	coins += 1
	coin_counter.text = str(coins)
	
	if coins == stage_coins:
		get_parent().get_node("Timers/StageClearTimer").start()

func _on_dead_zone_entered():
	get_tree().reload_current_scene()
	
func _on_stage_clear_timeout():
	var file_name = "res://scenes/world/stage" + str(stage + 1) + ".tscn"
	if FileAccess.file_exists(file_name):
		get_tree().change_scene_to_file(file_name)
	else:
		get_tree().change_scene_to_file("res://scenes/world/menu.tscn")
