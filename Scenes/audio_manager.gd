extends Node3D

class_name MyAudioManager

static var Singleton = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func Play(name: String):
	var sfx = find_child(name)
	if sfx is AudioStreamPlayer:
		sfx.play()
		
func Stop(name: String):
	var sfx = find_child(name)
	if sfx is AudioStreamPlayer:
		sfx.stop()
