extends Node

var coins = 0

@onready var coin_counter: Label = $CoinCounter

func _on_coin_collected():
	coins += 1
	coin_counter.text = str(coins)
