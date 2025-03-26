extends Node3D

@export var controller: Control

func _ready():
	self.material = controller.resource
