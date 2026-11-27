class_name CelestrialBody
extends RigidBody3D

var universe: Universe

var _current_velocity: Vector3 = Vector3.ZERO

@export var initial_velocity: Vector3

func _ready() -> void:
	_current_velocity = initial_velocity

func update_velocity(other_planets: Array[CelestrialBody], timeStep: float) -> void:
	for other_planet in other_planets:
		if other_planet == self:
			continue

		var sqr_dst: float = (other_planet.global_position - self.global_position).length_squared()
		var force_dir: Vector3 = (other_planet.global_position - self.global_position).normalized()
		var force: Vector3 = (force_dir * universe.gravitational_constant * self.mass * other_planet.mass) / sqr_dst
		var acceleration: Vector3 = force / mass;

		_current_velocity += acceleration * timeStep


func update_position(delta: float):
	global_position += _current_velocity * delta
