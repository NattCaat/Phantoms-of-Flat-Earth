extends SpringArm


export var mouseSensitivity := 0.05

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouseSensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -80, 80)
		rotation_degrees.y -= event.relative.x * mouseSensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)

	if event.is_action_pressed("ZoomIn") && spring_length > 0:
		spring_length -= 1
	if event.is_action_pressed("ZoomOut") && spring_length < 3:
		spring_length += 1
