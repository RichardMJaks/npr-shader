@tool
extends Node3D

@export_tool_button("Toggle rotating") var button = toggle_rotating

func toggle_rotating() -> void:
    for child in get_children():
        child.rotating = not child.rotating