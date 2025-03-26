@tool
extends Node3D

var objects: Dictionary[String, Node3D] = {}
var currently_displayed: Node3D = null

@export var rotatable_objects: Array[Node3D]
var rotate_axis: Vector3 = Vector3.ZERO:
	get:
		return rotate_axis.normalized()
@export_range(0, 1) var rotation_randomization: float = 0.05
@export_range(0, 3) var speed: float = 0.3
var rotating: bool = true

func _ready() -> void:
	if not Engine.is_editor_hint():
		objects = {}
		for child in get_children():
			child.visible = false
			objects[child.name] = child
	show_object(objects.keys()[0])

func show_object(obj_name: String) -> void:
	print("Showing " + obj_name)
	if currently_displayed:
		currently_displayed.visible = false
	
	currently_displayed = objects[obj_name]
	currently_displayed.visible = true

func _process(delta: float) -> void:
	for obj in rotatable_objects:    
		rotate_axis += Vector3(
			randf_range(-rotation_randomization, rotation_randomization),
			randf_range(-rotation_randomization, rotation_randomization),
			randf_range(-rotation_randomization, rotation_randomization)
		)
		obj.rotate(rotate_axis, PI * speed * delta)
