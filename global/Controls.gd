extends Node

func _unhandled_input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
	elif event.is_action_pressed("toggle-fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen)
