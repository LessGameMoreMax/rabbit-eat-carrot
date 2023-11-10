extends MeshInstance3D

class_name MyGrid

static var GridScene = preload("res://Scenes/grid.tscn")
static var jsonfile = "user://grid.json"
static var grid_data = {}

var item: MyItem = null
var index_x: int = 0
var index_z: int = 0
var grid_name: String = "DefaultGrid"
var timer: Timer
var monster_timer: Timer

func _ready():
	timer = $Timer
	monster_timer = $MonsterTimer
	pass

func _process(delta):
	pass

static func LoadGrid(index: int)->MyGrid:
	var grid: MyGrid = MyGrid.GridScene.instantiate()
	grid.grid_name = MyGrid.grid_data[index]["grid_name"]
	grid.item = MyItem.LoadItem(MyGrid.grid_data[index]["grid_index"])
	grid.add_child(grid.item)
	return grid

static func LoadJson():
	var file = FileAccess.open(MyGrid.jsonfile, FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	MyGrid.grid_data = json.data
	return

func _on_area_3d_area_entered(area):
	timer.start(0.4 / MyConfig.character_speed)

func _on_timer_timeout():
	item.PossesCharacter(MyLevel.character)

func _on_monster_area_area_entered(area):
	monster_timer.start(0.4 / MyConfig.monster_speed)


func _on_monster_timer_timeout():
	item.PossesCharacter(MyLevel.monster)
