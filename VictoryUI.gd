extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_victory_signal():
	show()
	pass


func _on_retry_pressed():
	hide()
	pass


func _on_exit_pressed():
	hide()
	pass
