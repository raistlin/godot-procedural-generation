class_name Projectile
extends KinematicBody2D


#warning-ignore: unused_signal
signal collided(target)


var lifetime := 1.0
var motions := []
var direction := Vector2.UP
var multiple_projectiles_active := true

var _last_offset := Vector2.ZERO
var _is_setup := false


func setup(_position: Vector2, _direction: Vector2, _motions: Array, _lifetime: float) -> void:
	position = _position
	direction = _direction
	lifetime = _lifetime
	
	if not _is_setup:
		for motion in _motions:
			var new_motion = motion.duplicate()
			new_motion.projectile = self
			motions.append(new_motion)
		_is_setup = true

	_post_setup()


func _post_setup() -> void:
	pass


func _impact() -> void:
	pass


func _miss() -> void:
	pass


# Calculates and returns the projectile's movement this frame.
# Mutates the projectile's state, so be sure to only call it when the time changes.
func _update_movement(delta: float) -> Vector2:
	if motions.empty():
		return Vector2.ZERO

	var offset := Vector2.ZERO
	for motion in motions:
		offset += motion._update_movement(direction, delta)

	var movement_vector := offset
	return movement_vector
