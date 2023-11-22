extends MyItem

class_name EndItem

var end_item_mesh: MeshInstance3D = null

signal victory_signal

func _ready():
	end_item_mesh = load("res://Scenes/end_item.tscn").instantiate()
	add_child(end_item_mesh)
	pass


func _process(delta):
	pass
	
func PossesCharacter(character: MyCharacter):
	if character == MyLevel.monster:
		super.PossesCharacter(character)
		return
	character.should_move = false
	end_item_mesh.position.y = 2.0
	victory_signal.emit()
	return
