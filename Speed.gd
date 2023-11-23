extends Button

var should_speed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "2X"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if not should_speed:
		text = "1X"
		MyLevel.character.speed_param = 4
		if MyLevel.monster != null:
			MyLevel.monster.speed_param = 4
	else:
		text = "2X"
		MyLevel.character.speed_param = 2
		if MyLevel.monster != null:
			MyLevel.monster.speed_param = 2
	should_speed = not should_speed
	pass


func _on_exit_pressed():
	pass # Replace with function body.
