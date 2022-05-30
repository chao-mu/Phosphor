extends CanvasLayer

const MAX_TERMINAL_LINE_LENGTH := 60
const MAX_TERMINAL_LINE_COUNT := 15
const PROMPT := "> "
const SHIFT_PREFIX := "Shift+"
const EXIT_COMMAND := "exit"
const INCORRECT_ANSWER_MSG := "Incorrect."
const HELP_MSG := "Type " + EXIT_COMMAND + " to exit."
var input := ""

export(String) var question = "[placeholder]" setget set_question, get_question
export(String) var answer = "[placeholder]"
export(String) var scene_path

onready var lines := [self.question]

func _unhandled_key_input(event: InputEventKey) -> void:
	if !event.is_pressed():
		return

	_on_key(event.as_text())

func _process(_delta: float) -> void:
	$Text.text = ""
	for line in lines:
		$Text.text += line + "\n"
	
	$Text.text += PROMPT + input

func _on_enter() -> void:
	if input.to_lower() == answer.to_lower():
		get_tree().change_scene(scene_path)
		return
	
	if input == EXIT_COMMAND:
		exit()
		return

	lines.append(PROMPT + input)
	lines.append(INCORRECT_ANSWER_MSG)
	lines.append(self.question)
	
	while len(lines) > MAX_TERMINAL_LINE_COUNT - 1: 
		lines.pop_front()
	
	input = ""
	
func _on_key(key: String):
	if key == "Enter":
		_on_enter()
	
	if key == "BackSpace" and len(input) > 0:
		input.erase(len(input) - 1, 1)

	if key.begins_with(SHIFT_PREFIX):
		key.erase(0, len(SHIFT_PREFIX))
	else:
		key = key.to_lower()

	if len(key) != 1:
		return
		
	if len(input) >= MAX_TERMINAL_LINE_LENGTH:
		return
		
	input = input + key
	
func exit():
	queue_free()

func set_question(new_question: String) -> void:
	question = new_question
	
func get_question() -> String:
	return question + " " + HELP_MSG
