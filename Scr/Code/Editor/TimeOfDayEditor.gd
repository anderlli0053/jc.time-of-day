@tool
class_name TimeOfDayEditor extends EditorPlugin

const _SunScript = preload("res://addons/jc.time-of-day/Scr/Code/Celestials/Sun/Sun.gd")
const _SunIcon = preload("res://addons/jc.time-of-day/Scr/Graphics/Icons/DirectionalLight3D.svg")

func _enter_tree():
	add_custom_type("Sun", "Node3D", _SunScript, _SunIcon)

func _exit_tree():
	remove_custom_type("Sun");
