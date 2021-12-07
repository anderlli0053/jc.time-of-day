@tool
class_name Sun extends Node3D
#========================================================
#°                         TimeOfDay.
#°                   ======================
#°
#°   Category: Sun.
#°   -----------------------------------------------------
#°   Description:
#°       Sun celestial body.
#°   -----------------------------------------------------
#°   Copyright:
#°               J. Cuellar 2021. MIT License.
#°                   See: LICENSE File.
#========================================================

# Graphics.
var _sun_material: ShaderMaterial = preload(
	"res://addons/jc.time-of-day/Scr/Code/Celestials/Sun/sun_material.material"
)

const _sun_shader: Shader = preload(
	"res://addons/jc.time-of-day/Scr/Shaders/Sun.gdshader"
);

var _full_screen_quad: QuadMesh = QuadMesh.new()
var _sun_graphics_instance: RID

# Direction.
var _old_transform: Transform3D
var _direction: Vector3 = Vector3.ZERO
signal direction_changed(value)

# Params.
var _disk_color: Color = Color(1.0, 1.0, 1.0, 1.0)
@export var disk_color: Color:
	get: return _disk_color
	set(value):
		_disk_color = value
		if _sun_graphics_instance != null:
			RenderingServer.instance_geometry_set_shader_parameter(_sun_graphics_instance, "_Color", _disk_color)
			

var _disk_size: float = 0.03
@export var disk_size: float:
	get: return _disk_size
	set(value):
		_disk_size = value
		if _sun_graphics_instance != null:
			RenderingServer.instance_geometry_set_shader_parameter(_sun_graphics_instance, "_DiskSize", _disk_size)

func _init() -> void:
	_old_transform = transform
	_full_screen_quad.size = Vector2(2.0, 2.0)
	_sun_material.shader = _sun_shader

func _notification(what) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			add_to_group("Suns", true)
			_create_graphics()
			_init_properties()
			_get_direction()
		NOTIFICATION_EXIT_TREE:
			remove_from_group("Suns")
			RenderingServer.free_rid(_sun_graphics_instance)
#			_sun_graphics_instance = RID()
	

func _init_properties():
	disk_color = disk_color

func _process(delta) -> void:
	if(_old_transform != transform):
		_get_direction()
		_old_transform = transform

func _get_direction() -> void:
	_direction = transform.basis * Vector3.FORWARD
	emit_signal("direction_changed", _direction)
	if(_sun_graphics_instance != null):
		RenderingServer.instance_geometry_set_shader_parameter(_sun_graphics_instance, "_Direction", _direction)

func _create_graphics() -> void:
	_sun_graphics_instance = RenderingServer.instance_create()
	var sc = get_world_3d().scenario
	RenderingServer.instance_set_scenario(_sun_graphics_instance, sc)
	RenderingServer.instance_set_base(_sun_graphics_instance, _full_screen_quad)
	
	var xf = Transform3D(Basis(), Vector3.ZERO)
	RenderingServer.instance_set_transform(_sun_graphics_instance, xf)
	
	RenderingServer.instance_geometry_set_material_override(_sun_graphics_instance, _sun_material)
	RenderingServer.instance_set_extra_visibility_margin(_sun_graphics_instance, 16000.0)
	RenderingServer.instance_geometry_set_cast_shadows_setting(_sun_graphics_instance, RenderingServer.SHADOW_CASTING_SETTING_OFF)
