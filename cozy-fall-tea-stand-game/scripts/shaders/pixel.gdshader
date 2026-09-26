shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform int pixel_size : hint_range(1, 64) = 8; // Change this value to adjust pixel size

void fragment() {
    // Get screen pixel size
    vec2 size = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 uv = floor(SCREEN_UV * size / float(pixel_size)) * float(pixel_size) / size;
    
    // Sample the screen texture with pixelated UVs
    COLOR = texture(SCREEN_TEXTURE, uv);
}
