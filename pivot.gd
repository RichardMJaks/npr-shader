@tool
extends Node3D

var rotate_axis: Vector3 = Vector3.ZERO:
	get:
		return rotate_axis.normalized()
@export_range(0, 1) var rotation_randomization: float = 0.05
@export_range(0, 1) var distance: float = 0.5
@export_range(0, 3) var speed: float = 0.3
@onready var rt: RemoteTransform3D = get_child(0)
var rotating: bool = true

func _ready() -> void:
	if not Engine.is_editor_hint():
		rotation_degrees = Vector3(0, 90, 0)
	rotate_axis = Vector3(
		randf_range(-rotation_randomization, rotation_randomization),
		randf_range(-rotation_randomization, rotation_randomization),
		randf_range(-rotation_randomization, rotation_randomization)
	)

func _process(delta: float) -> void:
	rt.position.x = -distance;
	
	if not rotating:
		return
	
	rotate_axis += Vector3(
		randf_range(-rotation_randomization, rotation_randomization),
		randf_range(-rotation_randomization, rotation_randomization),
		randf_range(-rotation_randomization, rotation_randomization)
	)
	rotate(rotate_axis, PI * speed * delta)
