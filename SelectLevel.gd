extends ColorRect

class_name SelectLevel

static var LevelButtonScenePath = "res://Scenes/level_button.tscn"
static var Singleton = null

signal load_level_signal(index)

func _ready():
	Singleton = self
	len(MyLevel.level_data)
	for i in range(1, len(MyLevel.level_data)):
		var button: LevelButton = load(LevelButtonScenePath).instantiate()
		button.level_button_index = i
		i -= 1
		button.position = Vector2(size.x / 2 - 250 + (i % 5) * 100, 100 + (i / 5) * 100)
		add_child(button)
	pass


func _process(delta):
	pass
	
static func LoadLevel(index):
	Singleton.hide()
	Singleton.load_level_signal.emit(index)
	pass


func _on_exit_pressed():
	show()
	pass
