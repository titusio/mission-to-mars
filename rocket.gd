extends CelestrialBody
class_name Rocket

@export var orbiting: CelestrialBody

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

