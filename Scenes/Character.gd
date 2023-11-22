extends MeshInstance3D

class_name MyCharacter

static var ScenePath = "res://Scenes/character.tscn"

var ForwardSearchLength = 0.06
var BesideSearchLength = MyConfig.grid_width
var speed: Vector3
var speed_param: float = MyConfig.character_speed
var should_search: bool = true
var should_move: bool = true
var should_jump: bool = false
var tile: MyTile = null
var target_grid: MyGrid = null

var jump_time = MyConfig.jump_grid_number * MyConfig.grid_width / speed_param
var jump_speed = MyConfig.jump_height / jump_time
var cur_time = 0.0
var position_y = 0.0

signal die_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if should_search:
		SearchRoad()
	if should_move:
		Move(delta)
	if should_jump:
		Jump(delta)
	return
	
func SearchRoad():
	# Search "Forward"
	var forward_position = global_position + speed * ForwardSearchLength
	if MySelectManager.current_state == MySelectManager.State.Selected and MySelectManager.current_tile == tile:
		assert(tile != null)
		if tile.GetGridByCoord(forward_position) != null: return
	else:
		# May Condition Race When Exchange Two Tile
		var forward_tile = MyLevel.tile_map.GetTileByCoord(forward_position)
		if forward_tile != null:
			var forward_grid = forward_tile.GetGridByCoord(forward_position)
			if forward_grid != null:
				if forward_tile != tile:
					tile.remove_child(self)
					forward_tile.add_child(self)
					position = forward_grid.position - speed * MyConfig.grid_width / 2.0
					position.y = 1
					tile = forward_tile
				return
	speed *= -1	
	return	
	
func Move(delta):
	global_position += speed * delta * speed_param
	return
	
func Die():
	should_move = false
	die_signal.emit()
	return
	
func BeginJump(target_grid: MyGrid):
	should_search = false
	self.target_grid = target_grid
	should_jump = true
	position_y = position.y
	return

#TODO: If Land On Item, Time of Event Timer May Wrong!
func FinishJump():
	should_search = true
	self.target_grid = null
	should_jump = false
	cur_time = 0.0
	return
	
func Jump(delta):
	assert(target_grid != null)
	cur_time += delta
	if cur_time > jump_time:
		FinishJump()
	else:
		var m = MyConfig.jump_grid_number * MyConfig.grid_width
		var a = -(4.0 * MyConfig.jump_height) / (m * m)
		var x = speed_param * cur_time
		position.y = a * (x * x - m * x) + position_y
	return



