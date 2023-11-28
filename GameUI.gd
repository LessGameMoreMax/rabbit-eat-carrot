extends ColorRect

var level_index: int = 0

func _ready():
	pass


func _process(delta):
	pass

func _on_select_level_load_level_signal(index):
	level_index = index
	$Label.text = "第" + str(level_index) + "关"
	show()
	pass


func _on_exit_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	hide()
	$Speed.should_speed = false
	$Speed.text = "2X"
	pass
	
func _on_victory_signal():
	hide()
	$Speed.should_speed = false
	$Speed.text = "2X"
	pass
	
func _on_die_signal():
	hide()
	$Speed.should_speed = false
	$Speed.text = "2X"
	pass

func _on_retry_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	show()
	$Speed.should_speed = false
	$Speed.text = "2X"
	pass # Replace with function body.


func _on_gameui_retry_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	$Speed.should_speed = false
	$Speed.text = "2X"
	pass # Replace with function body.
