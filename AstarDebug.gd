extends Control

@export @onready var board: AstarTileMap
@export var disabled := false

func position_has_obstacle(obstacle_position):
	return board.position_has_obstacle(obstacle_position) or board.position_has_unit(obstacle_position)

func _draw():
	if disabled:
		return
	var astar := board.astar
	if !astar: return
	var offset = Vector2(0, 0)
	for point in astar.get_point_ids():
		if astar.is_point_disabled(point): continue
		var point_position = astar.get_point_position(point)
		if position_has_obstacle(point_position): continue

		draw_circle(point_position+offset, 2, Color.WHITE)

		var point_connections = astar.get_point_connections(point)
		var connected_positions = []
		for connected_point in point_connections:
			if astar.is_point_disabled(connected_point): continue
			var connected_point_position = astar.get_point_position(connected_point)
			if position_has_obstacle(connected_point_position): continue
			connected_positions.append(connected_point_position)

		for connected_position in connected_positions:
			draw_line(point_position+offset, connected_position+offset, Color.WHITE, 1)
