shader_type canvas_item;

uniform vec3 base_color = vec3(0.6, 0.6, 0.0);
uniform vec3 highlight_color = vec3(1.0, 1.0, 0.0);

void fragment() {
	if (COLOR.a > 0.5 && COLOR.b <= 0.4 && COLOR.r > 0.1 && COLOR.g > 0.1
	&& abs(COLOR.r - COLOR.g) < 0.2) {
		float animation = sin(TIME * 2.0);
		vec3 final_color = mix(base_color, highlight_color, animation);
		COLOR = vec4(final_color, 1.0);
	}
}
