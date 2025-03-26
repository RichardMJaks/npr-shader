extends ColorPicker

@export var param_name: String
@export var controlbox: Control

func _ready():
	color = controlbox.resource.get_shader_parameter(param_name)
