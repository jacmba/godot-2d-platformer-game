extends Sprite2D

class_name HealthHeart

func update_health(health):
	var target_frame = GameData.MAX_HEALTH - health
	frame = target_frame
