extends PanelContainer

@export var resource: ShaderMaterial

func _on_button_pressed() -> void:
	print("pressed")
	resource.set_shader_parameter("step_spot", 1)


func _cel_step_slider(value:float) -> void:
	resource.set_shader_parameter("step_spot", value)

func _specular_step_slider(value:float) -> void:
	resource.set_shader_parameter("specular_step_spot", value)


func _fresnel_slider(value:float) -> void:
	resource.set_shader_parameter("fresnel_param", value)
	pass # Replace with function body.


func _specular_strength_slider(value:float) -> void:
	resource.set_shader_parameter("specular_strength", value)
	pass # Replace with function body.


func _specular_intensity_slider(value:float) -> void:
	resource.set_shader_parameter("specular_intensity", value)
	pass # Replace with function body.


func _smoothing_slider(value:float) -> void:
	resource.set_shader_parameter("smoothing", value)
	pass # Replace with function body.



func _fresnel_step(value:float) -> void:
	resource.set_shader_parameter("fresnel_step", value)


func _color_picker(color:Color) -> void:
	resource.set_shader_parameter("color", color)
