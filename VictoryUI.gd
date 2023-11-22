extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_victory_signal():
	show()
	MySelectManager.should_input = false
	pass


func _on_retry_pressed():
	hide()
	MySelectManager.should_input = true
	pass


func _on_exit_pressed():
	hide()
	MySelectManager.should_input = true
	pass
