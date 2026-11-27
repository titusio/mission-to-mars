class_name Universe
extends Node3D

@export var gravitational_constant: float = 1.0
@export var enabled: bool = true

var _celestrialBodies: Array[CelestrialBody] = []

func _ready() -> void:
	for child in get_children():
		if child is CelestrialBody:
			_celestrialBodies.append(child)
			child.universe = self

	simulate()


func _physics_process(delta: float) -> void:
	if !enabled:
		return

	for p: CelestrialBody in _celestrialBodies:
		p.update_velocity(_celestrialBodies, delta)

	for p: CelestrialBody in _celestrialBodies:
		p.update_position(delta)


func simulate(steps: int = 1000) -> void:
	var delta: float = 0.001

	var velocities: Dictionary[CelestrialBody, Vector3] = {}
	var positions: Dictionary[CelestrialBody, PackedVector3Array] = {}

	# initialize array
	for b: CelestrialBody in _celestrialBodies:
		positions[b] = [b.global_position]
		velocities[b] = b.current_velocity

	# simulate
	for i in range(steps):
		for b: CelestrialBody in _celestrialBodies:
			b.update_velocity(_celestrialBodies, delta)
			b.update_position(delta)
			positions[b].append(b.global_position)

	# reset
	for b: CelestrialBody in _celestrialBodies:
		b.global_position = positions[b].get(0)
		b.current_velocity = velocities[b]
		b.draw_path(positions[b])
