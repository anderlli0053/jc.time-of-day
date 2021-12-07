@tool
class_name TimeOfDayEditor extends EditorPlugin

const _TODScript = preload(
	"res://addons/jc.time-of-day/Scr/Code/TimeOfDay/TimeOfDay.gd"
)
const _TODIcon = preload(
	"res://addons/jc.time-of-day/Scr/Graphics/Icons/Sky.svg"
)

func _enter_tree():
	add_custom_type("TimeOfDay", "Node3D", _TODScript, _TODIcon)
	
func _exit_tree():
	remove_custom_type("TimeOfDay");
