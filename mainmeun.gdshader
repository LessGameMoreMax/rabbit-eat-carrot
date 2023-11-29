shader_type canvas_item;

uniform sampler2D picture;

void fragment() {
	COLOR = texture(picture, UV);
}
