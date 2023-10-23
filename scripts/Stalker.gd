extends Node

class_name Stalker

@onready var chat_container = %ChatContainer

@onready var delay_between_messages = $delay_between_messages

var stalker: Chatter

var state: states

enum states {OUT, SHUT_UP, STORY_TIME, MENACING}

var can_write:= true

const shut_up_messages: PackedStringArray = ["Shut up", "I said shut up", "Are you dumb? SHUT UP", "SHUT-UP-NOW"]
var current_shut_up_index:=0

func write_message(message: String):
	stalker.message = message
	stalker.date_time_dict = Time.get_datetime_dict_from_system()
	chat_container.create_chatter_msg(stalker, false, true)

func init_stalker_chatter(channel_info: TwitchChannel):
	var new_chatter = Chatter.new()
	new_chatter.channel = channel_info.login
	new_chatter.tags = IRCTags.new()
	new_chatter.tags.badges = {}
	new_chatter.tags.emotes = {}
	new_chatter.tags.display_name = "Stalker490"
	new_chatter.tags.color_hex = "FF0000"
	stalker = new_chatter

func _on_sound_threshold_reached():
	if !can_write: return
	
	match state:
		states.SHUT_UP:
			var message_text = shut_up_messages[current_shut_up_index]
			if current_shut_up_index < 1: message_text = FormatUtils.shake_light(message_text)
			else: message_text = FormatUtils.shake_strong(message_text)
			write_message(message_text)
			current_shut_up_index = current_shut_up_index + 1
			if current_shut_up_index == shut_up_messages.size(): current_shut_up_index = 0
			delay_between_messages.start(10)
			can_write = false
			
func _on_delay_between_messages_timeout():
	can_write = true
