extends KinematicBody


export var speed := 0.0
export var jumpHight := 5.0
export var gravity := 50.0

var velocity := Vector3.ZERO
var snapVector := Vector3.DOWN

signal playerPos(pos)

var maskd := false

func _ready():
	pass
	#OS.window_fullscreen = true


func _physics_process(delta):
	moveInput(delta)
	if Input.is_action_just_pressed("m1"):
		$"..".add_child(load("res://Scenes/FlatEarth.tscn").instance())
	emit_signal("playerPos", translation)

func _process(delta):
	$CollisionShape.rotation.y = $SpringArm.rotation.y
	$playerModel.rotation_degrees.y = $SpringArm.rotation_degrees.y - 180
	$MaskPlayer.rotation_degrees.y = $SpringArm.rotation_degrees.y - 180
	$SpotLight.rotation_degrees = $SpringArm.rotation_degrees
	
	if maskd:
		$playerModel.visible = false
		$MaskPlayer.visible = true
	else:
		$playerModel.visible = true
		$MaskPlayer.visible = false

func moveInput(delta):
	var MoveDirection := Vector3.ZERO
	MoveDirection.z = Input.get_action_strength("s") - Input.get_action_strength("w")
	MoveDirection.x = Input.get_action_strength("d") - Input.get_action_strength("a")
	MoveDirection = MoveDirection.rotated(Vector3.UP, $SpringArm.rotation.y).normalized()
	velocity.x = MoveDirection.x * speed
	velocity.z = MoveDirection.z * speed
	velocity.y -= gravity * delta
	
	var justLanded := is_on_floor() && snapVector == Vector3.ZERO
	var isJumping := is_on_floor() && Input.is_action_just_pressed("jump")
	if isJumping:
		velocity.y = jumpHight
		snapVector = Vector3.ZERO
	elif justLanded:
		snapVector = Vector3.DOWN
	velocity = move_and_slide_with_snap(velocity, snapVector, Vector3.UP, true)
	return velocity



func _on_Sheople_iAmNew(test):
	connect("playerPos", test, "_on_Player_playerPos")
