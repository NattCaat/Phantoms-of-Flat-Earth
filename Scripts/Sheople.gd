extends KinematicBody

export var lives := 3

var playerPos := Vector3.ZERO

signal iAmNew(test)

func _ready():
	if get_parent().has_node("Player"):
		$"../Player".connect("playerPos", self, "_on_Player_playerPos")
	emit_signal("iAmNew", self)
	
func _process(delta):
	if lives <= 0:
		queue_free()


func _on_Player_playerPos(pos):
	playerPos = pos
