shader_type canvas_item;

void fragment() {
	COLOR.r *= cos(TIME) * 10.0;
	COLOR.b *= cos(TIME) * 10.0;
	COLOR.a *= sin(TIME) * 10.0 * cos(VERTEX.y);
	
	if (COLOR.a < 0.0) {
		COLOR.a *= -1.0;
	}
}
