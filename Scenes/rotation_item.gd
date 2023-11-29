extends Node3D

class_name RotationItemScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$rotation_item_2.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func ShowClock():
	$rotation_item_2.visible = false
	$rotation_item_1.visible = true

func ShowUnClock():
	$rotation_item_2.visible = true
	$rotation_item_1.visible = false

