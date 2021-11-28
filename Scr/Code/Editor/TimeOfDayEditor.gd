@tool
class_name TimeOfDayEditor extends EditorPlugin

const _TimeOfDayScript = preload("res://addons/jc.time-of-day/Scr/Code/TimeOfDay/TimeOfDay.gd")
const _TimeOfDayIcon = preload("res://Default/icon.png")

func _enter_tree():
	add_custom_type("TimeOfDay", "Node", _TimeOfDayScript, _TimeOfDayIcon)

func _exit_tree():
	remove_custom_type("TimeOfDay");
