extends Label

var time_start = 0

var is_counting: bool

func start_counting(): # we will call this in the start of the "Stream"
	time_start = Time.get_unix_time_from_system()
	is_counting = true

func _process(delta):
	if !is_counting: return
	text = "Uptime: " + seconds_to_hhmmss(Time.get_unix_time_from_system()-time_start)

func seconds_to_hhmmss(total_seconds: float) -> String:
	#total_seconds = 12345
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	var hours:  int   =  int(total_seconds / 3600.0)
	var hhmmss_string:String = "%02d:%02d:%02d" % [hours, minutes, seconds]
	return hhmmss_string
