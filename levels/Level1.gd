extends Node2D

func _ready() -> void:
	Helpers.show_dialog("timeline-waking-up")
	Audio.fade_in_scene()
