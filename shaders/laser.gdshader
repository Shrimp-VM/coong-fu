shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0, 0.1, 0.2, 1.0);
uniform float intensity : hint_range(0.0, 10.0) = 3.0;
uniform float beam_width : hint_range(0.0, 1.0) = 0.08;
uniform float soft_edge : hint_range(0.0, 1.0) = 0.25;
uniform float speed : hint_range(0.0, 20.0) = 6.0;
uniform float noise_strength : hint_range(0.0, 1.0) = 0.15;
uniform float flicker_strength : hint_range(0.0, 1.0) = 0.2;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

void fragment() {
    vec2 uv = UV;
    vec2 centered = uv - vec2(0.5);

    // 横向流动噪声，让激光边缘不完全死板
    float n = noise(vec2(uv.x * 12.0 - TIME * speed, uv.y * 4.0));
    float n2 = noise(vec2(uv.x * 30.0 - TIME * speed * 1.7, uv.y * 10.0));
    float distortion = (n * 0.7 + n2 * 0.3 - 0.5) * noise_strength;

    // 以中线为激光核心
    float d = abs(centered.y + distortion);

    // 核心亮线 + 外层光晕
    float core = smoothstep(beam_width, 0.0, d);
    float glow = smoothstep(beam_width + soft_edge, 0.0, d);

    // 闪烁
    float flicker = 1.0 + flicker_strength * sin(TIME * 30.0 + uv.x * 20.0);
    flicker *= 1.0 + flicker_strength * 0.5 * noise(vec2(TIME * 8.0, uv.x * 5.0));

    // 能量流
    float flow = 0.75 + 0.25 * sin((uv.x - TIME * speed * 0.15) * 40.0);

    float energy = (core * 2.0 + glow * 0.8) * intensity * flicker * flow;

    vec3 col = color.rgb * energy;
    float alpha = clamp(energy, 0.0, 1.0);

    COLOR = vec4(col, alpha);
}