extends MyCharacter

class_name MyMonster

static var MonsterScenePath = "res://Scenes/monster.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	pass


func _on_area_3d_area_entered(area):
	print("GameOver")
	MyLevel.character.Die()
	pass
