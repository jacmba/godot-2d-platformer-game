extends Node

@onready var coin_counter: Label = $CoinCounter
@onready var gameData: GameData = GameData.getInstance()

func _ready():
	gameData.restoreLevel()
	coin_counter.text = str(gameData.getCoins())

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		exit_to_menu()
		
func die():
	get_parent().get_node("Stage/Timers/DeathTimer").start()
	
func exit_to_menu():
	get_tree().change_scene_to_file("res://scenes/world/menu.tscn")

func _on_coin_collected():
	gameData.collectCoin()
	coin_counter.text = str(gameData.getCoins())

func _on_dead_zone_entered():
	die()
	
func _on_stage_clear_timeout():
	gameData.advanceStage()
	var file_name = "res://scenes/world/stage" + str(gameData.getStage()) + ".tscn"
	if FileAccess.file_exists(file_name):
		get_tree().change_scene_to_file(file_name)
	else:
		exit_to_menu()

func _on_death_timer_timeout():
	get_tree().reload_current_scene()
	
func _on_dead():
	die()
	
func _on_goal_entered(_body):
	get_parent().get_node("Stage/Timers/StageClearTimer").start()
