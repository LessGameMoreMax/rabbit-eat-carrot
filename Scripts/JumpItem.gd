extends MyItem

class_name JumpItem

var jump_item_mesh: MeshInstance3D = null

func _ready():
	jump_item_mesh = load("res://Scenes/jump_item.tscn").instantiate()
	add_child(jump_item_mesh)
	return

func _process(delta):
	pass
	
func PossesCharacter(character: MyCharacter):
	if character.should_jump :
		super.PossesCharacter(character)
		return
	var target_position = character.global_position + character.speed * MyConfig.grid_width * MyConfig.jump_grid_number
	
	var target_tile = null
	var target_grid = null
	
	if MySelectManager.current_state == MySelectManager.State.Selected and MySelectManager.current_tile == character.tile:
		target_tile = character.tile
		target_grid = target_tile.GetGridByCoord(target_position)
	else:
		target_tile = MyLevel.tile_map.GetTileByCoord(target_position)
		if target_tile == null:
			super.PossesCharacter(character)
			return
		target_grid = target_tile.GetGridByCoord(target_position)

	if target_grid == null:
		super.PossesCharacter(character)
		return
	
	# Change Tile	
	if target_tile != character.tile:
		character.tile.remove_child(character)
		target_tile.add_child(character)
		var temp_position = target_grid.position - character.speed * MyConfig.grid_width * MyConfig.jump_grid_number
		character.position.x = temp_position.x
		character.position.z = temp_position.z
		character.tile = target_tile
		
	# Jump
	character.BeginJump(target_grid)
	return
