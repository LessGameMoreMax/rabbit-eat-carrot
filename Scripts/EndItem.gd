extends MyItem

class_name EndItem

var end_item_mesh: MeshInstance3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	end_item_mesh = load("res://Scenes/end_item.tscn").instantiate()
	add_child(end_item_mesh)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func PossesCharacter(character: MyCharacter):
	character.should_move = false
	end_item_mesh.position.y = 2.0
	return
