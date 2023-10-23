extends ChatMessage

class_name StalkerMessage 

var try_delete_message: PackedStringArray = [
	"What are you trying to do?",
	"That won't work",
	"I'm in control here",
	"Don't even dare",
	"You are mine",
	"The system is mine",
]
	
func _on_delete_button_pressed():
	var original_text = $RichTextLabel.text
	var splitted_text: PackedStringArray = $RichTextLabel.text.split(": ", true, 1)
	splitted_text[1] = FormatUtils.light_red(get_random_delete_message())
	
	var joined_text: String = ": ".join(splitted_text)
	
	$RichTextLabel.text = splitted_text[0] + ": "
	var from_tween = $RichTextLabel.get_total_character_count()
	$RichTextLabel.text = joined_text
	var to_tween = $RichTextLabel.get_total_character_count()
	
	$RichTextLabel.text = original_text
	
	$RichTextLabel.visible_characters = $RichTextLabel.get_total_character_count()
	var new_message_tween = create_tween()
	new_message_tween.tween_property($RichTextLabel, "visible_characters", from_tween, 0.5)
	new_message_tween.tween_callback($RichTextLabel.set_text.bind(joined_text))
	new_message_tween.tween_property($RichTextLabel, "visible_characters", to_tween, 1).from(from_tween)
	
	$DeleteButton.disabled = true

func get_random_delete_message() -> String:
	return try_delete_message[randi_range(0, try_delete_message.size()-1)]
