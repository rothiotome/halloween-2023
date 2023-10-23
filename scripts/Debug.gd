extends Control

func _ready():
	create_button(start_uptime)
	create_button(start_audio_blame)
	create_button(stop_audio_blame)
	create_button(start_streamer_message_ingame)
	create_button(stop_streamer_message_ingame)
	create_button(start_frenzy_mode)
	create_button(stop_frenzy_mode)

func start_uptime():
	%Uptime.start_counting()
	
func start_audio_blame():
	%Stalker.state = Stalker.states.SHUT_UP
	
func stop_audio_blame():
	%Stalker.state =  Stalker.states.OUT
	
func start_streamer_message_ingame():
	$"../../..".streamer_messages_ingame = false
	
func stop_streamer_message_ingame():
	$"../../..".streamer_messages_ingame = true

func start_frenzy_mode():
	$"../../..".frenzy_mode = true
	
func stop_frenzy_mode():
	$"../../..".frenzy_mode = false
	
func create_button(method: Callable):
	var my_button = Button.new()
	my_button.pressed.connect(method)
	my_button.text = method.get_method()
	add_child(my_button)
