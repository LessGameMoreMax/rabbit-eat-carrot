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
	hide()
	pass
	
func _on_victory_signal():
	hide()
	pass
	
func _on_die_signal():
	hide()
	pass

func _on_retry_pressed():
	show()
	pass # Replace with function body.
