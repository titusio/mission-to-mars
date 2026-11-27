class_name CelestrialBody
extends RigidBody3D

var universe: Universe

var current_velocity: Vector3 = Vector3.ZERO

@export var initial_velocity: Vector3
@export var line: Line3D

func _ready() -> void:
	current_velocity = initial_velocity

func set_velocity(velocity: Vector3) -> void:
	current_velocity = velocity

func update_velocity(other_planets: Array[CelestrialBody], timeStep: float) -> void:
	for other_planet in other_planets:
		if other_planet == self:
			continue

		var sqr_dst: float = (other_planet.global_position - self.global_position).length_squared()
		var force_dir: Vector3 = (other_planet.global_position - self.global_position).normalized()
		var force: Vector3 = (force_dir * universe.gravitational_constant * self.mass * other_planet.mass) / sqr_dst
		var acceleration: Vector3 = force / mass;

		current_velocity += acceleration * timeStep


func update_position(delta: float):
	global_position += current_velocity * delta

func draw_path(positions: PackedVector3Array) -> void:
	if line == null:
		return

# 	if line.curve == null:
# 		push_warning("Curve of line is null")
# 		return
#
# 	line.curve.clear_points()
	var curve: Curve3D = Curve3D.new()


	for i in range(positions.size()):
		curve.add_point(positions.get(i))

	line.curve = curve
