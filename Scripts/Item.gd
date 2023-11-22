class_name MyItem extends Node3D

var item_name: String = "DefaultItem"

func _ready():
	pass

func _process(delta):
	pass
	
func PossesCharacter(character: MyCharacter):
	var left = false
	var right = false
	
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
	return

static func LoadItem(index: int)->MyItem:
	if index == 0:
		var item: MyItem = MyItem.new()
		item.item_name = "RoadItem"
		return item
	if index == 1:
		var item: EndItem = EndItem.new()
		item.item_name = "EndItem"
		item.victory_signal.connect(UserInterface.Singleton.get_child(2)._on_victory_signal)
		item.victory_signal.connect(UserInterface.Singleton.get_child(3)._on_victory_signal)
		return item
	if index == 2:
		var item: MyItem = RotationItem.new()
		item.item_name = "RotationItem"
		return item
	if index == 3:
		var item: MyItem = JumpItem.new()
		item.item_name = "JumpItem"
		return item
	return null
