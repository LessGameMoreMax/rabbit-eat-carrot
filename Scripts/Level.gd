extends Node

class_name MyLevel

@export var DefaultLevelInfoIndex: int = 0

static var jsonfile = "user://level.json"
static var level_data = {}

var level_index: int = 0
var level_name: String = "DefaultLevelName"
var map_index: int = 0

static var tile_map: MyTileMap
static var character: MyCharacter = null
static var monster: MyMonster = null

func _ready():
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
	character.die_signal.connect(UserInterface.Singleton.get_child(2)._on_die_signal)
	character.die_signal.connect(UserInterface.Singleton.get_child(4)._on_die_signal)
	tile.add_child(character)
	
	if level_data[index]["has_monster"] == 1:
		monster = load(MyMonster.MonsterScenePath).instantiate()
		monster.speed = Vector3(level_data[index]["monster_speed_x"], level_data[index]["monster_speed_y"], level_data[index]["monster_speed_z"])
		tile = tile_map.GetTile(level_data[index]["monster_tile_index_x"], level_data[index]["monster_tile_index_z"])
		monster.position = tile.GetGrid(level_data[index]["monster_grid_index_x"], level_data[index]["monster_grid_index_z"]).position
		monster.position.y = 1
		monster.tile = tile
		tile.add_child(monster)
	return


func _on_select_level_load_level_signal(index):
	LoadLevel(index)
	pass


func _on_retry_pressed():
	get_child(0).queue_free()
	if character != null:
		character.queue_free()
	if monster != null:
		monster.queue_free()
	character = null
	monster = null
	LoadLevel(level_index)
	pass


func _on_exit_pressed():
	get_child(0).queue_free()
	character = null
	monster = null
	pass
