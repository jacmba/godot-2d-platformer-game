class_name GameData

const INITIAL_LIVES: int = 3
const MAX_HEALTH = 4

var coins: int
var lives: int
var health: int
var stage: int

static var instance: GameData = null

static func getInstance() -> GameData:
	if instance == null:
		instance = GameData.new()
		
	return instance
	
func _init():
	newGame()
	restoreLevel()
	
func newGame():
	coins = 0
	lives = INITIAL_LIVES
	stage = 1
	
func restoreLevel():
	health = MAX_HEALTH
	
func getCoins() -> int:
	return coins
	
func collectCoin():
	coins += 1
	
func getLives() -> int:
	return lives
	
func die():
	lives -= 1
	
func getHealth() -> int:
	return health
	
func takeDamage(damage):
	health -= damage
	health = clamp(health, 0, MAX_HEALTH)
	
func powerup(power):
	takeDamage(-power)

func getStage() -> int:
	return stage
	
func advanceStage():
	stage += 1

