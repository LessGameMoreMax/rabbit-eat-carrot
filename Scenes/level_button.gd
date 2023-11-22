extends Button

class_name LevelButton

var level_button_index: int = 0

func _ready():
	text = str(level_button_index) 
	pass


func _process(delta):
	pass


func _on_pressed():
	SelectLevel.LoadLevel(level_button_index)
	pass
