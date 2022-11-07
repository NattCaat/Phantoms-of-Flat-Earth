extends Spatial


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("fullScreen") && OS.window_fullscreen == true:
		OS.window_fullscreen = false
	elif Input.is_action_just_pressed("fullScreen") && OS.window_fullscreen == false:
		OS.window_fullscreen = true
