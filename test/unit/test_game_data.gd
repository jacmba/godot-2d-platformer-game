extends GutTest

var data: GameData

func before_all():
	gut.p("Starting tests")
	data = GameData.getInstance()
	
func test_instance_is_not_null():
	assert_not_null(data, "Game data instance should not be null")
	
func test_initial_data():
	assert_eq(data.getCoins(), 0, "Coins should be 0")
	assert_eq(data.getLives(), 3, "Lives should be 3")
	assert_eq(data.getHealth(), 3, "Health should be 3")
	assert_eq(data.getStage(), 1, "Stage should be 1")
	
func test_collect_coins():
	data.collectCoin()
	assert_eq(data.getCoins(), 1, "Coins should be 1")
	data.newGame()
	assert_eq(data.getCoins(), 0, "Coins should be 0 again")
	
func test_decrease_lives():
	data.die()
	assert_eq(data.getLives(), 2, "Lives should be 2")
	data.newGame()
	assert_eq(data.getLives(), 3, "Lives should be 3 again")
	
func test_take_damage():
	data.takeDamage()
	assert_eq(data.getHealth(), 2, "Health should be 2")
	data.restoreLevel()
	assert_eq(data.getHealth(), 3, "Health should be 3 again")
	
func test_advance_level():
	data.advanceStage()
	assert_eq(data.getStage(), 2, "Stage should be 2")
	data.newGame()
	assert_eq(data.getStage(), 1, "Stage should be 1 again")
