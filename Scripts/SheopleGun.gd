extends KinematicBody


func _ready():
	pass

func _physics_process(delta):
	look_at($"..".playerPos, Vector3.UP)
	rotation_degrees = Vector3(0, rotation_degrees.y - 180,0)
	if $CollisionShape/RayCast.is_colliding():
		if $Timer.is_stopped():
			add_child(load("res://Scenes/maskProjectile.tscn").instance())
			$Timer.start()
