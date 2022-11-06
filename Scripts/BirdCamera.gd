extends SpotLight



func _process(delta: float) -> void:
	var globalPos = global_transform.origin
	var maxDistSquare = pow(spot_range, 2)
	light_color = Color.white
	
	for player in get_tree().get_nodes_in_group("player"):
		var playerPos = player.global_transform.origin
		if globalPos.distance_squared_to(playerPos) > maxDistSquare:
			continue
		
		var lightAngle = (
				-(global_transform.basis.z).angle_to(playerPos-globalPos)
		)
		
		if int(rad2deg(lightAngle)+180) % 180 < spot_angle:
			light_color = Color.red
