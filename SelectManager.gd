extends Camera3D

class_name MySelectManager

enum State {Idle, PreSelected, Selected}
const RayLength = 500.0

static var current_tile: MyTile = null
static var current_state: State = State.Idle
var should_input: bool = true
var covered_tile: MyTile = null

var level: MyLevel = null

var screen_position: Vector2
var last_screen_position: Vector2
var tile_screen_position: Vector2
var clicked : bool = false

func _ready():
	level = get_node("Level")
	pass

func _process(delta):
	pass
	
func _physics_process(delta):
	if current_state == State.Idle:
		var from = project_ray_origin(screen_position)
		var to = from + project_ray_normal(screen_position) * RayLength
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		if result.is_empty(): return
		var position: Vector3 = result.position
		var tile: MyTile = level.tile_map.GetTileByCoord(position)
		if tile == null or not tile.IsMoveable(): return
		current_tile = tile
		current_state = State.PreSelected
		current_tile.PreSelected()
		return
	if current_state == State.PreSelected:
		if clicked:
			current_tile.CanclePreSelected()
			level.tile_map.RemoveTile(current_tile)
			current_tile.Selected(project_ray_normal(screen_position))
			tile_screen_position = unproject_position(current_tile.position)
			current_state = State.Selected
			return
		var from = project_ray_origin(screen_position)
		var to = from + project_ray_normal(screen_position) * RayLength
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		if result.is_empty(): 
			current_tile.CanclePreSelected()
			current_tile = null
			current_state = State.Idle
			return
		var position: Vector3 = result.position
		var tile: MyTile = level.tile_map.GetTileByCoord(position)
		if tile == null or not tile.IsMoveable(): 
			current_tile.CanclePreSelected()
			current_tile = null
			current_state = State.Idle
			return
		if tile == current_tile: return
		current_tile.CanclePreSelected()
		current_tile = tile
		current_state = State.PreSelected
		current_tile.PreSelected()
		return
	if current_state == State.Selected:
		if clicked:
			level.tile_map.MoveTile(CaculateTileMove(last_screen_position, screen_position), current_tile)
			last_screen_position = screen_position
			var temp = level.tile_map.GetTileByCoord(current_tile.global_position)
			if temp != null and not temp.IsMoveable(): return
			if temp != covered_tile:
				if covered_tile != null:
					covered_tile.CancelCovered()
					covered_tile = null
				if temp != null:
					covered_tile = temp
					covered_tile.Covered()
			return
		level.tile_map.DropTile(current_tile, covered_tile)
		if covered_tile != null:
			covered_tile.CancelCovered()
		covered_tile = null
		current_tile.CancelSelected()
		current_tile = null
		current_state = State.Idle
		return
	return
	
func _input(event):
	if not should_input: return
	if current_state == State.Idle:
		if event is InputEventMouseMotion:
			screen_position = event.position
		return
	if current_state == State.PreSelected:
		if event is InputEventMouseMotion:
			screen_position = event.position
			return
		if event is InputEventMouseButton:
			screen_position = event.position
			last_screen_position = screen_position
			if event.pressed and event.button_index == 1:
				clicked = true
			return
	if current_state == State.Selected:
		screen_position = event.position
		if event is InputEventMouseButton:
			if not event.pressed and event.button_index == 1:
				clicked = false
		return
	return

func CaculateTileMove(last: Vector2, cur: Vector2) -> Vector3:
	tile_screen_position += cur - last
	var depth = (current_tile.global_position.y - global_position.y) / project_ray_normal(tile_screen_position).y
	var result = project_position(tile_screen_position, depth)
	result.y = current_tile.global_position.y
	return result
