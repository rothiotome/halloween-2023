extends HBoxContainer

class_name SendMessageController

@onready var line_edit: LineEdit = $LineEdit

signal on_streamer_message_sent

func _on_button_pressed():
	on_streamer_message_sent.emit(line_edit.text)
	line_edit.clear()
	
func _on_line_edit_text_submitted(new_text):
	on_streamer_message_sent.emit(line_edit.text)
	line_edit.clear()
