extends Node

class_name MyTileMap

var width: int = 0
var height: int = 0
var tile_map_name: String = "DefaultTileMap"
var map = {}

static var jsonfile = "user://tilemap.json"
static var tilemap_data = {}

func _ready():
	pass


func _process(delta):
	pass
	
func GetTile(x:int, z:int)->MyTile:
	var index: int = GetTileIndex(x, z)
	if not map.has(str(index)): return null
	return map[str(index)]
	
func GetTileByCoord(coordinate: Vector3)->MyTile:
	if coordinate.x < 0 or coordinate.z < 0: return null
	return GetTile(int(coordinate.x)/MyConfig.tile_width, int(coordinate.z)/MyConfig.tile_width)
		
func GetTileIndex(x:int, z:int)->int:
	if x < 0 or x > width - 1 or z < 0 or z > height - 1: return -1
	return width * z + x
	
func AddTile(tile: MyTile):
	map[str(GetTileIndex(tile.index_x, tile.index_z))] = tile
	
func RemoveTile(tile: MyTile):
	map.erase(str(GetTileIndex(tile.index_x, tile.index_z)))

func MoveTile(coordinate: Vector3, tile: MyTile):
	tile.global_position = coordinate
	return
	
func SetupTile(tile: MyTile):
	tile.SetPosition()
	add_child(tile)
	AddTile(tile)
	return
	
func DropTile(tile: MyTile, covered_tile: MyTile):
	MyAudioManager.Singleton.Play("DropTile")
	if covered_tile == null:
		tile.SetPosition()
		AddTile(tile)
		return
	RemoveTile(covered_tile)
	var temp_x = tile.index_x
	var temp_z = tile.index_z
	tile.index_x = covered_tile.index_x
	tile.index_z = covered_tile.index_z
	covered_tile.index_x = temp_x
	covered_tile.index_z = temp_z
	tile.SetPosition()
	covered_tile.SetPosition()
	AddTile(tile)
	AddTile(covered_tile)
	return
	
static func LoadJson():
	var file = FileAccess.open(MyTileMap.jsonfile, FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	MyTileMap.tilemap_data = json.data
	return
	
static func LoadTileMap(index: int)->MyTileMap:
	var tile_map = MyTileMap.new()
	tile_map.height = MyTileMap.tilemap_data[index]["tilemap_height"]
	tile_map.width = MyTileMap.tilemap_data[index]["tilemap_width"]
	tile_map.tile_map_name = MyTileMap.tilemap_data[index]["tilemap_name"]
	for tile_info in MyTileMap.tilemap_data[index]["tiles"]:
		var tile = MyTile.LoadTile(tile_info["tile_index"])
		tile.index_x = tile_info["index_x"]
		tile.index_z = tile_info["index_z"]
		tile_map.SetupTile(tile)
	return tile_map
