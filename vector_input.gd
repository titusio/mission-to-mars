extends HBoxContainer

@onready var x_input: LineEdit = $InX
@onready var y_input: LineEdit = $InY
@onready var z_input: LineEdit = $InZ

signal on_changed(value: Vector3)

@export var inital_value: Vector3

var _value: Vector3 = Vector3.ZERO

func _ready() -> void:
	set_value(inital_value)

func set_value(value: Vector3) -> void:
	x_input.text = str(value.x)
	y_input.text = str(value.y)
	z_input.text = str(value.z)

func x_changed(text: String) -> void:
	if !text.is_valid_float():
		return

	_value.x = text.to_float()
	on_changed.emit(_value)

func y_changed(text: String) -> void:
	if !text.is_valid_float():
		return

	_value.y = text.to_float()
	on_changed.emit(_value)

func z_changed(text: String) -> void:
	if !text.is_valid_float():
		return

	_value.z = text.to_float()
	on_changed.emit(_value)

func sumbit() -> void:
	if x_input.text.is_valid_float():
		_value.x = x_input.text.to_float()

	if y_input.text.is_valid_float():
		_value.y = y_input.text.to_float()

	if z_input.text.is_valid_float():
		_value.z = z_input.text.to_float()

	on_changed.emit(_value)
