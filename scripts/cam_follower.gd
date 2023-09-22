extends Camera2D

@onready var player: Node = get_node("../Player")
@onready var boundaries: Node = get_node("../Boundaries")
@onready var top_boundary: float = boundaries.get_node("Top").position.y
@onready var bottom_boundary: float = boundaries.get_node("Bottom").position.y
@onready var left_boundary: float = boundaries.get_node("Left").position.x
@onready var right_boundary: float = boundaries.get_node("Right").position.x

func _process(delta):
	if player == null:
		print("Can't get reference to player")
		return
		
	var target_position = player.position
	
	if boundaries == null:
		print("Can't get reference to scenery boundaries")
	else:
		if target_position.y < top_boundary:
			target_position.y = position.y
		elif target_position.y > bottom_boundary:
			target_position.y = position.y
		if target_position.x < left_boundary:
			target_position.x = position.x
		elif target_position.x > right_boundary:
			target_position.x = position.x
	
	position = target_position
