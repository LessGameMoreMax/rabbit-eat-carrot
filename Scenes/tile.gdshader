shader_type spatial;

uniform vec3 color;
uniform sampler2D noise;

void fragment() {
	float n = texture(noise, UV).r;
	ALBEDO = color * n + vec3(1.0, 1.0, 1.0) * (1.0 - n);
}
