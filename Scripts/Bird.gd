extends StaticBody


signal alarm(position)

onready var animationPlayer := $AnimationPlayer
onready var spotlight := $SpotLight

var player
var attackMode = false


func _ready() -> void:
	animationPlayer.get_animation("default").loop = true
	animationPlayer.play("default")
	player = $"%Player"


func _process(_delta: float) -> void:
	var globalPos = spotlight.global_transform.origin
	var maxDistSquare = pow(spotlight.spot_range, 2)
	spotlight.light_color = Color.white
	
	if not attackMode:
		var playerPos = player.global_transform.origin
		if globalPos.distance_squared_to(playerPos) > maxDistSquare:
			return
		
		var lightAngle = (
				-(spotlight.global_transform.basis.z).angle_to(playerPos-globalPos)
		)
		
		if int(rad2deg(lightAngle)+180) % 180 < spotlight.spot_angle:
			spotlight.light_color = Color.red
			emit_signal("alarm", global_transform.origin)
			attackMode = true
	else:
		animationPlayer.stop()
		look_at(player.transform.origin, Vector3.UP)
		rotate(Vector3.UP, PI)
		spotlight.look_at(player.transform.origin, Vector3.UP)
		spotlight.light_color = Color.red
