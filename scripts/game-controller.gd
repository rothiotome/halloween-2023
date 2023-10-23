extends Control

@onready var chat_container: ChatContainer = %ChatContainer

@onready var twitch_api: TwitchAPI = %TwitchAPI
@onready var twitch_chat: TwitchChat = %TwitchChat

@onready var stalker: Stalker = %Stalker

var streamer_messages_ingame:= true

var angry_message: String = "I SEE YOU"
var frenzy_mode:= false

var channel_info: TwitchChannel

var streamer: Chatter

func _ready():
	twitch_api.initiate_twitch_auth()
	(%SendMessageController as SendMessageController).connect("on_streamer_message_sent", streamer_message_sent)

func _on_twitch_api_on_token_received(c_info:TwitchChannel):
	channel_info = c_info
	stalker.init_stalker_chatter(c_info)
	twitch_chat.start_chat_client(c_info)

func _on_twitch_chat_on_message(chatter: Chatter):
	if streamer == null && chatter.is_broadcaster(): streamer = chatter
	
	if(frenzy_mode): chatter.message = angry_message
	
	chat_container.create_chatter_msg(chatter)
	
func write_streamer_message(message: String, only_ingame: bool = true):
	if streamer == null: return
	streamer.message = message
	streamer.date_time_dict = Time.get_datetime_dict_from_system()
	chat_container.create_chatter_msg(streamer)
	if !only_ingame: twitch_chat.send_chat_message(message)
	
func streamer_message_sent(message: String):
	write_streamer_message(message, streamer_messages_ingame)

func _on_sound_threshold_reached():
	pass
