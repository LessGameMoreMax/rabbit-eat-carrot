extends MeshInstance3D

class_name MyTile

static var TileScene = preload("res://Scenes/tile.tscn")
static var UpLength = 5.0
static var jsonfile = "user://tile.json"
static var tile_data = {}

var index_x: int = 0
var index_z: int = 0
var tile_name: String = ""
var material: ShaderMaterial
var map = {}
var moveable: int = 1

func _ready():
	material = get_surface_override_material(0) as ShaderMaterial
	if IsMoveable():
		material.set_shader_parameter("color", Color.AQUAMARINE)
	else:
		material.set_shader_parameter("color", Color.DIM_GRAY)
	return

func _process(delta):
	pass
	
func SetPosition():
	global_position = Vector3(index_x * MyConfig.tile_width + MyConfig.tile_width / 2.0, 0, index_z * MyConfig.tile_width + MyConfig.tile_width / 2.0)
	return

func PreSelected():
	material.set_shader_parameter("color", Color.YELLOW)
	return
	
func CanclePreSelected():
	material.set_shader_parameter("color", Color.AQUAMARINE)
	return
	
func Selected(normal: Vector3):
	MyAudioManager.Singleton.Play("DragTile")
	material.set_shader_parameter("color", Color.RED)
	global_position -= normal * UpLength
	return

func CancelSelected():
	material.set_shader_parameter("color", Color.AQUAMARINE)
	return
	
func Covered():
	material.set_shader_parameter("color", Color.LIME)
	return
	
func CancelCovered():
	material.set_shader_parameter("color", Color.AQUAMARINE)
	return
	
func AddGrid(grid: MyGrid):
	grid.position = Vector3(grid.index_x * MyConfig.grid_width + MyConfig.grid_width / 2.0 - MyConfig.tile_width / 2.0, 0.5, grid.index_z * MyConfig.grid_width + MyConfig.grid_width / 2.0 - MyConfig.tile_width / 2.0)
	map[str(Vector2(grid.index_x, grid.index_z))] = grid
	add_child(grid)
	return
	
func GetGrid(index_x: int, index_z: int)->MyGrid:
	if index_x < 0 or index_z < 0 or index_x > MyConfig.grid_number - 1 or index_z > MyConfig.grid_number - 1: return null
	if not map.has(str(Vector2(index_x, index_z))): return null
	return map[str(Vector2(index_x, index_z))]

func GetGridByCoord(coordinate: Vector3)->MyGrid:
	var coord = coordinate - global_position + Vector3(MyConfig.tile_width / 2.0, 0.0, MyConfig.tile_width / 2.0)
	if coord.x < 0 or coord.z < 0 or coord.x > MyConfig.tile_width or coord.z >= MyConfig.tile_width: return null
	return GetGrid(int(coord.x / MyConfig.grid_width), int(coord.z / MyConfig.grid_width))
	
func RotateClockwise(character: MyCharacter, degree: float):
	var temp = GetGridByCoord(character.global_position)
	var new_map = {}
	for key in map:
		var grid = map[key]
		grid.position = grid.position.rotated(Vector3(0.0, 1.0, 0.0), deg_to_rad(degree))
		var coord = (grid.position + Vector3(MyConfig.tile_width / 2.0, 0.0, MyConfig.tile_width / 2.0)) / MyConfig.grid_width
		grid.index_x = int(coord.x)
		grid.index_z = int(coord.z)
		new_map[str(Vector2(grid.index_x, grid.index_z))] = grid
	character.position = temp.position
	character.position.y = 1
	map = new_map

func IsMoveable()->bool:
	return moveable == 1
	
static func LoadJson():
	var file = FileAccess.open(MyTile.jsonfile, FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	MyTile.tile_data = json.data
	return

static func LoadTile(index: int)->MyTile:
	var tile: MyTile = TileScene.instantiate()
	tile.tile_name = tile_data[index]["tile_name"]
	tile.moveable = tile_data[index]["moveable"]
	for grid_info in tile_data[index]["grids"]:
		var grid: MyGrid = MyGrid.LoadGrid(grid_info["grid_index"])
		grid.index_x = grid_info["index_x"]
		grid.index_z = grid_info["index_z"]
		tile.AddGrid(grid)
	return tile
