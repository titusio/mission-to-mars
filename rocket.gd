extends CelestrialBody
class_name Rocket

@export var orbiting: CelestrialBody

@onready var model: Node3D = $Model

func orbit() -> void:
	if orbiting != null: create_orbit(orbiting)

func create_orbit(relative_body: CelestrialBody, trigger_simulation: bool = true) -> void:
	if relative_body == self:
		push_error("Cannot create orbit around self")
		return

	var distance: float = (relative_body.global_position - self.global_position).length()
	var velocity: float = universe.gravitational_constant * relative_body.mass
	velocity = sqrt(velocity / distance)

	if is_zero_approx(current_velocity.length()):
		push_warning("Cannot use a zero current velocity for orbit creation")
		return

	current_velocity = current_velocity.normalized() * velocity

	if trigger_simulation: universe.simulate()

func _process(_delta: float) -> void:
	if current_velocity.length_squared() < 0.0001:
		return

	var direction = current_velocity.normalized()
	model.look_at(model.global_position + direction, Vector3.UP)
	model.rotate_object_local(Vector3.LEFT, deg_to_rad(90))
