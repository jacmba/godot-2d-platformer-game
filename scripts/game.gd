extends Node

class_name Game

@onready var coin_counter: Label = $CoinCounter
@onready var gameData: GameData = GameData.getInstance()
@onready var lives_counter: Label = $LivesCounter

func _ready():
	gameData.restoreLevel()
	updateCounters()
	
func updateCounters():
	coin_counter.text = str(gameData.getCoins())
	lives_counter.text = str(gameData.getLives())
	$HealthHeart.update_health(gameData.getHealth())

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		exit_to_menu()
		
func die():
	gameData.die()
	get_parent().get_node("Stage/Timers/DeathTimer").start()
	
func exit_to_menu():
	get_tree().change_scene_to_file("res://scenes/world/menu.tscn")

func _on_coin_collected():
	gameData.collectCoin()
	updateCounters()

func _on_dead_zone_entered():
	die()
	
func _on_stage_clear_timeout():
	gameData.advanceStage()
	var file_name = "res://scenes/world/stage" + str(gameData.getStage()) + ".tscn"
	get_tree().change_scene_to_file(file_name)

func _on_death_timer_timeout():
	if gameData.getLives() > 0:
		get_tree().reload_current_scene()
	else:
		exit_to_menu()
	
func _on_dead():
	die()
	
func _on_damaged(damage, _pos):
	gameData.takeDamage(damage)
	updateCounters()
	if gameData.getHealth() == 0:
		get_tree().call_group("death_listeners", "_on_dead")
	
func _on_goal_entered(_body):
	get_parent().get_node("Stage/Timers/StageClearTimer").start()
