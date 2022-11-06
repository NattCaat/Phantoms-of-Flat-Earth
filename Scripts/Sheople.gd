extends KinematicBody

export var lives := 3
export var speed := 6.0
export var senseRadius := 25

onready var player := get_node("/root/Spatial/Player")
onready var navi := $Navi

var playerPos := Vector3.ZERO


func _ready():
	player.connect("playerPos", self, "_on_Player_playerPos")
	$Timer.connect("timeout", self, "_on_search_player")
	_on_search_player()



func _physics_process(delta: float) -> void:
	var dir = global_transform.origin.direction_to(navi.get_next_location())
	dir = Vector3(dir.x, 0, dir.z).normalized()
	translate(dir * delta * speed)
	if (dir != Vector3.ZERO):
		var oldRotY = $CollisionShape.rotation.y
		$CollisionShape.look_at(
				navi.get_next_location(), Vector3.UP
		)
		$CollisionShape.rotation = Vector3(
				0, lerp(oldRotY, $CollisionShape.rotation.y-PI, 0.3), 0
		)


func _process(delta):
	if lives <= 0:
		queue_free()


func _on_search_player():
	navi.set_target_location(player.global_transform.origin)


func _on_Player_playerPos(pos):
	playerPos = pos
