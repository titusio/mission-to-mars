class_name Universe
extends Node3D

@export var gravitational_constant: float = 1.0

var _planets: Array[CelestrialBody] = []

func _ready() -> void:
	for child in get_children():
		if child is CelestrialBody:
			_planets.append(child)
			child.universe = self


func _physics_process(delta: float) -> void:
	for p: CelestrialBody in _planets:
		p.update_velocity(_planets, delta)

	for p: CelestrialBody in _planets:
		p.update_position(delta)
