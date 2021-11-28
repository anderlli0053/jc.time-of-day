@tool
class_name OrbitalElement extends Resource
#========================================================
#°                         TimeOfDay.
#°                   ======================
#°
#°   Category: Orbital Element.
#°   -----------------------------------------------------
#°   Description:
#°       Orbital element use for celestial positions.
#°   -----------------------------------------------------
#°   Copyright:
#°               J. Cuellar 2021. MIT License.
#°                   See: LICENSE File.
#========================================================
enum OrbitalElementType{ Sun = 0, Moon = 1, Custom = 2 }

var _orbital_element: OrbitalElementType = OrbitalElementType.Sun
var orbital_element: OrbitalElementType:
	get: return _orbital_element
	set(value):
		_orbital_element = value
		notify_property_list_changed()

var _N: float # Longitude of the ascending node.
var N: float:
	get: return _N
	set(value):
		_N = value

var _i: float # The Inclination to the ecliptic.
var i: float:
	get: return _i
	set(value):
		_i = value

var _w: float # Argument of perihelion.
var w: float:
	get: return _w
	set(value):
		_w = value

var _a: float # Semi-major axis, or mean distance from sun.
var a: float:
	get: return _a
	set(value):
		_a = value

var _e: float # Eccentricity.
var e: float:
	get: return _e
	set(value):
		_e = value

var _M: float # Mean anomaly
var M: float:
	get: return _M
	set(value):
		_M = value

func get_orbital_elements(timeScale: float) -> void:
	match orbital_element:
		OrbitalElementType.Sun:
			N = 0.0
			i = 0.0
			w = 282.9404 + 4.70935e-5 * timeScale
			a = 0.0
			e = 0.016709 - 1.151e-9 * timeScale
			M = 356.0470 + 0.9856002585 * timeScale
		OrbitalElementType.Moon:
			N = 125.1228 - 0.0529538083 * timeScale
			i = 5.1454
			w = 318.0634 + 0.1643573223 * timeScale
			a = 60.2666
			e = 0.054900
			M = 115.3654 + 13.0649929509 * timeScale

func _get_property_list():
	var ret: Array
	ret.push_back({name = "Orbital Element", type=TYPE_NIL, usage=PROPERTY_USAGE_CATEGORY})
	ret.push_back({name = "orbital_element", type=TYPE_INT, hint=PROPERTY_HINT_ENUM, hint_string="Sun, Moon, Custom"})
	
	if orbital_element == OrbitalElementType.Custom:
		ret.push_back({name = "N", type=TYPE_FLOAT})
		ret.push_back({name = "i", type=TYPE_FLOAT})
		ret.push_back({name = "w", type=TYPE_FLOAT})
		ret.push_back({name = "a", type=TYPE_FLOAT})
		ret.push_back({name = "e", type=TYPE_FLOAT})
		ret.push_back({name = "M", type=TYPE_FLOAT})
	
	return ret
