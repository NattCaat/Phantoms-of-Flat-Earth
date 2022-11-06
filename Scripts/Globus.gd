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

func _physics_process(delta):
#	translate(-Vector3.FORWARD * 0.2)
	pass
