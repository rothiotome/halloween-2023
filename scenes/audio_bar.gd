extends TabBar

@onready var audio_stream_player: AudioStreamPlayer = $VBoxContainer/AudioStreamPlayer
@onready var audio_bar: TextureProgressBar = $VBoxContainer/TextureProgressBar
@onready var option_mics: OptionButton = $VBoxContainer/OptionMics

signal on_threshold_reached

const peak_threshold = 0.5

var bus_index: int

func _ready():
	bus_index = AudioServer.get_bus_index(audio_stream_player.bus)
	var device_index = 0
	for mic in AudioServer.get_input_device_list() as PackedStringArray:
		option_mics.add_item(mic, device_index)
		device_index = device_index + 1

func _process(_delta):
	var sample = AudioServer.get_bus_peak_volume_left_db(bus_index, 0)
	
	var linear_sample = db_to_linear(sample)*10
	audio_bar.value = linear_sample
	
	if linear_sample > 0.5: on_threshold_reached.emit(linear_sample)

func _on_option_mics_item_selected(index):
	AudioServer.input_device = option_mics.get_item_text(index)
