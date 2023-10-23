extends Resource

class_name Chatter

var date_time_dict: Dictionary
var login: String
var channel: String
var message: String
var tags:IRCTags

func is_mod()-> bool:
	return tags.badges.has("moderator")

func is_sub()-> bool:
	return tags.badges.has("subscriber")
	
func is_broadcaster() -> bool:
	return tags.badges.has("broadcaster")

