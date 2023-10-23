extends Node

class_name FormatUtils

static func shake_light(text: String) -> String:
	return ("[shake rate=20.0 level=5 connected=1]%s[/shake]" % [text])

static func shake_strong(text:String) -> String:
	return ("[shake rate=30.0 level=9 connected=1]%s[/shake]" % [text])
	
static func light_red(text: String) -> String:
	return (("[color=DC143C]%s[/color]" % [text]))
