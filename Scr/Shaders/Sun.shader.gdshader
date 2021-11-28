shader_type spatial;
render_mode unshaded, depth_draw_never, cull_disabled, blend_add;

uniform vec3 _direction = vec3(1.0, 0.0, 0.0);
uniform float _disk_size = 0.1;
uniform vec4 _color: hint_color = vec4(1.0);

float disk(vec3 norm, vec3 coords, lowp float size){
	float dist = length(norm - coords);
	return 1.0 - step(size, dist);
}

vec3 mul43(mat4 m, vec4 v){
	return (m * v).xyz;
}

vec4 mul44(mat4 m, vec4 v){
	return (m * v);
}

varying mat4 camera_matrix;
void vertex(){
	POSITION = vec4(VERTEX.xy, 0.0, 1.0);
	camera_matrix = CAMERA_MATRIX;
}

void fragment(){
	// ViewDir
	vec4 view = mul44(INV_PROJECTION_MATRIX, vec4(SCREEN_UV * 2.0 - 1.0, 1.0, 1.0));
	vec3 viewDir = view.xyz / view.w;
	
	// worldPos.
	view = CAMERA_MATRIX * view;
	view.xyz /= view.w;
	view.xyz -= (CAMERA_MATRIX * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
	vec3 worldPos = normalize(view).xyz;
	ALBEDO = disk(worldPos, _direction, _disk_size) * _color.rgb;
}