extends Node

var PasswordEntry = preload("res://ui/PasswordEntry.tscn")

func is_dialog_open():
	return not is_dialog_open()

func is_dialog_closed():
	return get_tree().get_root().find_node('DialogNode', true, false) == null
	
func show_dialog(timeline_name: String) -> void:
	pause()
	var dialog = Dialogic.start(timeline_name)
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect('timeline_end', self, '_on_timeline_end')
	dialog.connect('dialogic_signal', self, '_on_dialog_signal')

	add_child(dialog)
	
func _on_timeline_end(_type):
	unpause()
	
func pause() -> void:
	get_tree().paused = true
	
func unpause() -> void:
	get_tree().paused = false

func _on_dialog_signal(arg: String):
	print(arg)
	display_password_prompt(arg)

func display_password_prompt(level: String) -> void:
	var password_entry = PasswordEntry.instance()
	
	if level == "level_2":
		password_entry.question = "What is your name?"
		password_entry.answer = "Penelope"
		password_entry.scene_path = "res://levels/Level2.tscn"

	get_tree().current_scene.add_child(password_entry)
