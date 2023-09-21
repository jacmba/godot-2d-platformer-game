extends Node

@export var coin_list: Node

var coins = 0

@onready var coin_counter: Label = $CoinCounter
@onready var stage_coins = coin_list.get_child_count()

func _on_coin_collected():
	coins += 1
	coin_counter.text = str(coins)
	
	if coins == stage_coins:
		get_tree().change_scene_to_file("res://scenes/world/stage.tscn")

func _on_dead_zone_entered():
	get_tree().reload_current_scene()
