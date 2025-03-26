shader_type spatial;

uniform vec4 color: source_color;
uniform float ambient_strength: hint_range(0.0, 5.0, 0.01) = 1.0;
uniform float step_spot: hint_range(0.0, 1.0, 0.01) = 0.3;
uniform float specular_step_spot: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float light_strength: hint_range(0.1, 3.0, 0.01) = 1.0;
uniform float smoothing: hint_range(0.0, 0.05, 0.001) = 0.0;
uniform float fresnel_param: hint_range(0.0, 3.6, 0.1) = 1.4;
uniform float specular_intensity: hint_range(0.0, 15.0, 0.1) = 3;
uniform float specular_strength: hint_range(0.0, 5.0, 0.1) = 1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = color.rgb;
}

float cel_diffuse(vec3 normal, vec3 light, float attenuation) {
	normal = normalize(normal);
	light = normalize(light);

	// Doesn't take distance into account, needs some attenuation magic
	float ndl = dot(normal, light);
	float strength = smoothstep(step_spot, step_spot + smoothing, ndl * attenuation);

	return strength * light_strength;
}

float cel_fresnel(vec3 normal, vec3 light, vec3 view) {
	normal = normalize(normal);
	light = normalize(light);
	view = normalize(view);

	float r0_1 = 1.0 - fresnel_param;
	float r0_2 = 1.0 + fresnel_param;
	float r0 = pow(r0_1 / r0_2, 2);

	float ndv = clamp(dot(normal, view), 0, 1);

	float f_1 = 1.0 - r0;
	float f_2 = pow(1.0 - ndv, 5);
	float f = 1.0 - step(r0 + f_1 * f_2, step_spot);

	return f;
}

float cel_specular(vec3 normal, vec3 light, vec3 view) {
	vec3 halfway = normalize(light + view); // Subtract to avoid specular showing behind
	float ndh = max(dot(halfway, normal), 0);
	float power = pow(ndh, specular_intensity);

	float result = 1.0 - step(power, specular_step_spot);
	return result;
}

void light() {
	// Variables
	vec3 normal = NORMAL;
	vec3 light = LIGHT;
	vec3 view = VIEW;
	vec3 light_color = normalize(LIGHT_COLOR);
	vec3 total_light = light_color * light_strength;

	// Lighting effects (mostly based on Phong model)
	vec3 ambient = light_color * ambient_strength; // Don't implement this Fedir, just use world env
	float diffuse = cel_diffuse(normal, light, ATTENUATION);
	float fresnel = cel_fresnel(normal, light, view);
	float specular = cel_specular(normal, light, view);

	// Apply lighting effects
	DIFFUSE_LIGHT += diffuse * total_light + fresnel * diffuse * total_light;
	// Apply specular in diffuse to
	SPECULAR_LIGHT += + specular * specular_strength * diffuse * total_light;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
