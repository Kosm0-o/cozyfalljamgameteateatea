shader_type canvas_item;

// 0.0 = eyes completely open, 1.0 = eyes completely closed
uniform float progress : hint_range(0.0, 1.0) = 0.0;
// Controls the transparency of the entire eyelid overlay (0.0 = invisible, 1.0 = fully solid)
uniform float eyelid_alpha : hint_range(0.0, 1.0) = 1.0;

uniform vec4 lid_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float eye_roundness : hint_range(0.5, 4.0) = 1.5;

void fragment() {
    // 1. Center horizontally [-1, 1]
    float x = (UV.x - 0.5) * 2.0;
    
    // 2. Create the almond shape curve
    float almond_curve = max(0.0, 1.0 - pow(abs(x), eye_roundness));
    
    // 3. Scale the opening based on progress
    float current_opening = almond_curve * (1.0 - progress);
    
    // 4. Distance from vertical center
    float dist_from_center = abs(UV.y - 0.5) * 2.0;
    
    // 5. Anti-aliasing edge softening (prevents pixelated lines)
    float edge_softness = 0.01; 
    float lid_mask = smoothstep(current_opening - edge_softness, current_opening, dist_from_center);
    
    // 6. Apply final color and combine the eyelid mask with your custom alpha variable
    vec4 final_color = lid_color;
    final_color.a *= lid_mask * eyelid_alpha;
    
    COLOR = final_color;
}
