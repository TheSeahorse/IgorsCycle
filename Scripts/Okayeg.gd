extends Area2D

var dialog_counter := 1

func get_dialog(specific:String = "default") -> String:
	var dialog = ""
	if dialog_counter == 1:
		dialog = "okayeg_1"
		increment_counter()
	elif dialog_counter == 2:
		dialog = "okayeg_2"
	else:
		dialog = "okayeg_last"
	return dialog


func increment_counter():
	dialog_counter += 1


func get_name() -> String:
	return "okayeg"
