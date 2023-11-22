extends Node3D

class_name MyConfig

static var grid_number = 5
static var grid_width = 2.0
static var tile_number = 10
static var tile_width = 10.0
static var jump_grid_number = 3
static var jump_height = 4
static var character_speed = 2
static var monster_speed = 2


func _init():
	MyGrid.LoadJson()
	MyTile.LoadJson()
	MyTileMap.LoadJson()
	MyLevel.LoadJson()
	return

func _ready():
	$UserInterface/MainMenu.show()
	pass

func _process(delta):
	pass
