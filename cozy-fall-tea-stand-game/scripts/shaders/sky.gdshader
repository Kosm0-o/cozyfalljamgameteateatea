shader_type canvas_item;

uniform vec4 color_horizon : source_color = vec4(0.95, 0.65, 0.45, 1.0); // Warm horizon
uniform vec4 color_zenith : source_color = vec4(0.20, 0.40, 0.70, 1.0);  // Deep sky
uniform int bands : hint_range(2, 20) = 5;                               // Number of flat layers

void fragment() {
	// Normalize screen UV coordinate (0.0 at top, 1.0 at bottom)
	// We invert it (1.0 - UV.y) so the horizon is at the bottom (0.0)
	float y_coord = 1.0 - UV.y;
	
	// Quantize the smooth gradient into distinct flat vector steps
	float float_bands = float(bands);
	float banded_y = floor(y_coord * float_bands) / (float_bands - 1.0);
	
	// Mix the colors using the sharp vector bands
	vec3 final_color = mix(color_horizon.rgb, color_zenith.rgb, clamp(banded_y, 0.0, 1.0));
	
	COLOR = vec4(final_color, 1.0);
}
