extends GutTest

var heart: HealthHeart

func before_each():
	heart = autofree(HealthHeart.new())
	add_child(heart)
	
func test_heart_not_null():
	assert_not_null(heart, "Heart instance should not be null")
	
func test_heart_should_have_sprite_0():
	assert_eq(heart.frame, 0, "Default frame should be 0")
