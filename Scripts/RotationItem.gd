extends MyItem

class_name RotationItem

var rotation_item_mesh: MeshInstance3D = null

var degree: float = -90.0

func _ready():
	rotation_item_mesh = load("res://Scenes/rotation_item.tscn").instantiate()
	add_child(rotation_item_mesh)
	return

func _process(delta):
	pass
	
func PossesCharacter(character: MyCharacter):
	character.tile.RotateClockwise(character, degree)
	var flag = 0
	if degree < 0:
		flag = 1
	else:
		flag = 0
	if abs(character.speed.x) == flag:
		character.speed = Vector3(character.speed.z, 0.0, character.speed.x)
	else:
		character.speed = Vector3(-character.speed.z, 0.0, -character.speed.x)
	degree *= -1.0
	var forward = false
	var left = false
	var right = false
	
	var forward_position = character.global_position + Vector3(character.speed.x, 0.0, character.speed.z) * character.BesideSearchLength
	if MySelectManager.current_state == MySelectManager.State.Selected and MySelectManager.current_tile == character.tile:
		if character.tile.GetGridByCoord(forward_position) != null: 
			forward = true
	else:
		var forward_tile = MyLevel.tile_map.GetTileByCoord(forward_position)
		if forward_tile != null and forward_tile.GetGridByCoord(forward_position) != null:
			forward = true
	
	var left_position = character.global_position + Vector3(character.speed.z, 0.0, character.speed.x) * character.BesideSearchLength
	if MySelectManager.current_state == MySelectManager.State.Selected and MySelectManager.current_tile == character.tile:
		if character.tile.GetGridByCoord(left_position) != null: 
			left = true
	else:
		var left_tile = MyLevel.tile_map.GetTileByCoord(left_position)
		if left_tile != null and left_tile.GetGridByCoord(left_position) != null:
			left = true
		
	var right_position = character.global_position + Vector3(-character.speed.z, 0.0, -character.speed.x) * character.BesideSearchLength
	if MySelectManager.current_state == MySelectManager.State.Selected and MySelectManager.current_tile == character.tile:
		if character.tile.GetGridByCoord(right_position) != null: 
			right = true
	else:
		var right_tile = MyLevel.tile_map.GetTileByCoord(right_position)
		if right_tile != null and right_tile.GetGridByCoord(right_position) != null:
			right = true
		
	if left and not right:
		character.speed = Vector3(character.speed.z, 0.0, character.speed.x)
		return
	
	if right and not left:
		character.speed = Vector3(-character.speed.z, 0.0, -character.speed.x)
		return
	
	if not forward:
		character.speed *= -1
	return
