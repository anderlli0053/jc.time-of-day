shader_type spatial;
render_mode unshaded, depth_draw_never, cull_disabled, blend_add;

vec3 Mul43(mat4 m, vec4 v){
	return (m * v).xyz;
}

vec4 Mul44(mat4 m, vec4 v){
	return m * v;
}

float Disk(vec3 norm, vec3 coords, lowp float size){
	float d = length(norm - coords);
	return 1.0 - step(size, d);
}

varying mat4 v_camera_matrix;
void vertex(){
	POSITION = vec4(VERTEX.xy, 0.0, 1.0);
	v_camera_matrix = CAMERA_MATRIX;
}

instance uniform vec3 _Direction = vec3(0.0, 1.0, 0.0);
instance uniform vec4 _Color: hint_color = vec4(1.0);
instance uniform float _DiskSize = 0.03;

void fragment(){
	// vec4(SCREEN_UV * 2.0 - 1.0, 0.0, 1.0) in GLES3 ?
	vec4 view = Mul44(INV_PROJECTION_MATRIX, vec4(SCREEN_UV * 2.0 - 1.0, 1.0, 1.0));
	vec3 viewDir = view.xyz / view.w;
	
	// WorldPos.
	view = v_camera_matrix * view;
	view.xyz /= view.w;
	view.xyz -= (v_camera_matrix * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
	vec3 worldPos = normalize(view).xyz;
	
	ALBEDO = Disk(worldPos, _Direction, _DiskSize) * _Color.rgb;
}
