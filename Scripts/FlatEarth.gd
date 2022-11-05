extends KinematicBody

var MoveDirection

func _ready():
	$FlatEarth.rotation_degrees.y = int(rand_range(0,360))
	rotation_degrees = $"../%Player/SpringArm".rotation_degrees
	translation = $"../%Player".translation + Vector3(0,1.9,0.15).rotated(Vector3.UP, $"../%Player/playerModel".rotation.y)

func _physics_process(delta):
	$FlatEarth.rotation_degrees.y += 10
	translate(Vector3.FORWARD * 0.2)
	if $Timer.is_stopped():
		queue_free()
