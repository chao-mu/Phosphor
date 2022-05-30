extends Area2D

var hint := false
var selectable := false

export(String) var timeline_path

onready var question_mark = $QuestionMark

func _ready() -> void:
	_update_visibility()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("activate") && selectable && Helpers.is_dialog_closed():
		Helpers.show_dialog(timeline_path)

func _process(_delta: float) -> void:
	_update_visibility()
	
func _on_InteractionZone_area_entered(area: Area2D) -> void:
	hint = true
	selectable = true

func _on_InteractionZone_area_exited(area: Area2D) -> void:
	hint = false
	selectable = false

func _update_visibility() -> void:
	if hint:
		question_mark.show()
	else:
		question_mark.hide()		
