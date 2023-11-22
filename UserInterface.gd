extends Control

class_name UserInterface

static var Singleton = null

func _ready():
	Singleton = self
	$MainMenu.show()
	$SelectLevel.hide()
	$GameUI.hide()
	$VictoryUI.hide()
	$DieUI.hide()
	pass


func _process(delta):
	pass


# MainMenu Button
func _on_button_pressed():
	$MainMenu.hide()
	$SelectLevel.show()
	pass
