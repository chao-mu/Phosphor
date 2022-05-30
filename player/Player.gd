extends KinematicBody2D


func _physics_process(_delta : float) -> void:
	var velocity : Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	) * Settings.PLAYER_SPEED
	
	velocity = move_and_slide(velocity)
