extends RigidBody


var MoveDirection

func _ready():
	$FlatEarth.rotation_degrees.y = int(rand_range(0,360))
	rotation_degrees = $"../%Player/SpringArm".rotation_degrees
	rotation_degrees.y -= 1
	translation = $"../%Player".translation + Vector3(0,2,0.15).rotated(Vector3.UP, $"../%Player/playerModel".rotation.y)
	add_force(-transform.basis.z * 15, translation)

func _physics_process(delta):
	$FlatEarth.rotation_degrees.y += 10
	if $Timer.is_stopped():
		queue_free()
	
	
	for body in get_colliding_bodies():
		if body.is_in_group("sheep"):
			body.lives -= 1
			queue_free()
