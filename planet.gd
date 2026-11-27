class_name Planet
extends Node3D

@export var spin: bool = false
@export var spin_speed: float = 0.0

func _process(delta: float) -> void:
	if !spin:
		return

	rotation_degrees.y += spin_speed * delta
