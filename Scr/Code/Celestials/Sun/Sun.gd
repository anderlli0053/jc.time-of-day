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

# Sun graphics.
# Instantiate or get light.

# Sun Graphics.
const _sun_shader: Shader = preload("res://addons/jc.time-of-day/Scr/Shaders/Sun.shader.gdshader")
var _sun_graphics_instance: RID
var _sun_fs_plane: QuadMesh = QuadMesh.new()
var _sun_material: ShaderMaterial = ShaderMaterial.new()


var _old_transform: Transform3D
var _direction: Vector3 = Vector3.ZERO

func _init() -> void:
	_sun_material.shader = _sun_shader;
	_sun_fs_plane.size = Vector2(2.0, 2.0)
	
	_old_transform = transform

func _notification(what) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			_create_sun_graphics()
		NOTIFICATION_EXIT_TREE:
			RenderingServer.free_rid(_sun_graphics_instance)
			_sun_graphics_instance = RID()


func _process(delta) -> void:
	if(_old_transform != transform):
		_direction = transform.basis * Vector3.FORWARD
		_sun_material.set_shader_param("_direction", _direction)
		print(_direction)
		_old_transform = transform

func _create_sun_graphics() -> void:
	_sun_graphics_instance = RenderingServer.instance_create()
	
	var scenario = get_world_3d().scenario
	RenderingServer.instance_set_scenario(_sun_graphics_instance, scenario)
	RenderingServer.instance_set_base(_sun_graphics_instance, _sun_fs_plane)
	
	var xf = Transform3D(Basis(), Vector3(0.0, 0.0, 0.0))
	RenderingServer.instance_set_transform(_sun_graphics_instance, xf)
	
	RenderingServer.instance_geometry_set_material_override(_sun_graphics_instance, _sun_material)
	RenderingServer.instance_set_extra_visibility_margin(_sun_graphics_instance, 16000.0)
	RenderingServer.instance_geometry_set_cast_shadows_setting(_sun_graphics_instance, RenderingServer.SHADOW_CASTING_SETTING_OFF)
