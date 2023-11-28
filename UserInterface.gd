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
	$ProductorUI.hide()
	pass


func _process(delta):
	pass


# MainMenu Button
func _on_button_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	$MainMenu.hide()
	$SelectLevel.show()
	MyAudioManager.Singleton.Play("UIShow")
	pass


func _on_button_3_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	get_tree().quit()
	pass


func _on_button_2_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	$MainMenu.hide()
	$ProductorUI.show()
	MyAudioManager.Singleton.Play("UIShow")
	pass


func _on_product_button_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	$ProductorUI.hide()
	$MainMenu.show()
	pass


func _on_select_button_pressed():
	MyAudioManager.Singleton.Play("ButtonPress")
	$SelectLevel.hide()
	$MainMenu.show()
	pass
