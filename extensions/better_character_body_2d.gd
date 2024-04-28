extends CharacterBody2D
class_name BetterCharacterBody2D

## Emitted the first time [method better_move_and_collide] collides with something in a frame.
signal collided_once(collision: KinematicCollision2D)

## Emitted all times [method better_move_and_collide] collides with something in a frame.
signal collided(collision: KinematicCollision2D)


@export var physics_max_bounces: int = 3


func better_move_and_collide(movement: Vector2):
	# How many times the body collided in the current physics step.
	var bounces: int = 0
	# While the body should still move some space, and it isn't stuck in a perpetual loop of bouncing...
	while movement.length() > 0.0 and bounces < physics_max_bounces:
		# Try to move!
		var collision: KinematicCollision2D = move_and_collide(movement)
		# If the body did not collide and performed its full movement, we're done!
		if not collision:
			break
		# Let's try to handle the collision properly
		bounces += 1
		# Emit the signals
		collided.emit(collision)
		if bounces == 1:
			collided_once.emit(collision)
		# Determine the normal of the collision (the direction the body should be pushed back in)
		var collision_normal = collision.get_normal()
		# Change the velocity adequately
		velocity = velocity.bounce(collision_normal)
		# Reflect the remaining movement
		movement = collision.get_remainder().bounce(collision_normal)
