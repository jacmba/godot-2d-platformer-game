shader_type canvas_item;

void fragment() {
	float alpha = COLOR.a * sin(TIME * 20.0);
	if (alpha < 0.5) {
		alpha = 0.5;
	}
	if (COLOR.a > 0.0) {
		COLOR.a = alpha;
	}
}
