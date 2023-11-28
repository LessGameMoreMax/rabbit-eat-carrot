extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_die_signal():
	MyAudioManager.Singleton.Play("Defeat")
	show()
	MySelectManager.should_input = false
	pass


func _on_exit_pressed():
	MyAudioManager.Singleton.Stop("Defeat")
	MyAudioManager.Singleton.Play("ButtonPress")
	hide()
	MySelectManager.should_input = true
	pass # Replace with function body.


func _on_retry_pressed():
	MyAudioManager.Singleton.Stop("Defeat")
	MyAudioManager.Singleton.Play("ButtonPress")
	hide()
	MySelectManager.should_input = true
	pass # Replace with function body.
