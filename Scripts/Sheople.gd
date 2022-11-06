extends KinematicBody

var playerPos := Vector3.ZERO

signal iAmNew(test)

func _ready():
	if get_parent().has_node("Player"):
		$"../Player".connect("playerPos", self, "_on_Player_playerPos")
	emit_signal("iAmNew", self)
	pass


func _on_Player_playerPos(pos):
	playerPos = pos
