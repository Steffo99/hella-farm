shader_type canvas_item;

uniform float intensity = 0.1;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	float color = round(fract(UV * 360.0).y);
	vec4 tex = texture(screen_texture, SCREEN_UV);
	COLOR = tex * (1.0 - intensity) + (tex * color * intensity);
}