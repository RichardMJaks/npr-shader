extends HSlider

@export var param_name: String
@export var controlbox: Control

func _ready():
    value = controlbox.resource.get_shader_parameter(param_name)