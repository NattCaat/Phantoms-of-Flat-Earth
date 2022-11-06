extends RigidBody


func _ready():
#	translation.z += .5
	rotation_degrees = $"..".rotation_degrees
	rotation_degrees.y -= 180
	add_force(-transform.basis.z * 1, translation)
	$CollisionShape.look_at($"../..".playerPos, Vector3.UP)
	$CollisionShape.rotation_degrees.x = 0
	$CollisionShape.rotation_degrees.y -= 180
	$CollisionShape.rotation_degrees.z = 0
	set_as_toplevel(true)

func _process(delta):
	if $Timer.is_stopped(): destroy()
	
	for body in get_colliding_bodies():
		if body.is_in_group("player"):
			body.maskd = true
		if !body.is_in_group("sheep"):
			destroy()
		
func destroy():
	queue_free()
