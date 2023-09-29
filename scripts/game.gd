extends Node

class_name Game

@export var coin_collect_sound: AudioStream
@export var music_sound: AudioStream

@onready var coin_counter: Label = $CoinCounter
@onready var gameData: GameData = GameData.getInstance()
@onready var lives_counter: Label = $LivesCounter
@onready var player: AudioStreamPlayer2D = $FXSound
@onready var music_player: AudioStreamPlayer2D = $Music

func _ready():
	gameData.restoreLevel()
	updateCounters()
	if music_sound != null:
		music_player.stream = music_sound
	music_player.play()
	
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
	playStream(coin_collect_sound)
	gameData.collectCoin()
	updateCounters()

func _on_dead_zone_entered():
	die()
	
func _on_stage_clear_timeout():
	gameData.advanceStage()
	var file_name = "res://scenes/world/stage" + str(gameData.getStage()) + ".tscn"
	get_tree().change_scene_to_file(file_name)

func _on_death_timer_timeout():
	music_player.stop()
	if gameData.getLives() > 0:
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene_to_file("res://scenes/world/gameover.tscn")
	
func _on_dead():
	die()
	
func _on_damaged(damage, _pos):
	gameData.takeDamage(damage)
	updateCounters()
	if gameData.getHealth() == 0:
		get_tree().call_group("death_listeners", "_on_dead")
	
func _on_goal_entered(_body):
	music_player.stop()
	get_parent().get_node("Stage/Timers/StageClearTimer").start()
	
func _on_powerup(power):
	gameData.powerup(power)
	updateCounters()
	
func playStream(stream: AudioStream):
	player.stream = stream
	player.play()
	
func _on_boss_killed():
	music_player.stop()
	get_parent().get_node("Stage/Timers/StageClearTimer").start()
