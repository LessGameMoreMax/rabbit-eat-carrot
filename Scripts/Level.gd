extends Node

class_name MyLevel

@export var DefaultLevelInfoIndex: int = 0

static var jsonfile = "user://level.json"
static var level_data = {}

var level_index: int = 0
var level_name: String = "DefaultLevelName"
var map_index: int = 0

static var tile_map: MyTileMap
static var character: MyCharacter
static var monster: MyMonster

func _ready():
	LoadLevel(DefaultLevelInfoIndex)
	return


func _process(delta):
	pass
	
static func LoadJson():
	var file = FileAccess.open(MyLevel.jsonfile, FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	MyLevel.level_data = json.data
	return
	
func LoadLevel(index: int):
	level_index = index
	level_name = level_data[index]["level_name"]
	map_index = level_data[index]["map_index"]	
	tile_map = MyTileMap.LoadTileMap(map_index)
	add_child(tile_map)
	character = load(MyCharacter.ScenePath).instantiate()
	character.speed = Vector3(level_data[index]["character_speed_x"], level_data[index]["character_speed_y"], level_data[index]["character_speed_z"])
	var tile: MyTile = tile_map.GetTile(level_data[index]["character_tile_index_x"], level_data[index]["character_tile_index_z"])
	character.position = tile.GetGrid(level_data[index]["character_grid_index_x"], level_data[index]["character_grid_index_z"]).position
	character.position.y = 1
	character.tile = tile
	tile.add_child(character)
	
	monster = load(MyMonster.MonsterScenePath).instantiate()
	monster.speed = Vector3(level_data[index]["monster_speed_x"], level_data[index]["monster_speed_y"], level_data[index]["monster_speed_z"])
	tile = tile_map.GetTile(level_data[index]["monster_tile_index_x"], level_data[index]["monster_tile_index_z"])
	monster.position = tile.GetGrid(level_data[index]["monster_grid_index_x"], level_data[index]["monster_grid_index_z"]).position
	monster.position.y = 1
	monster.tile = tile
	tile.add_child(monster)
	return
