extends RigidBody2D

var initial_self_position: Vector2 = Vector2.ZERO
var initial_mouse_position: Vector2 = Vector2.ZERO

@onready var rand_walk_timer: Timer = Timer.new()
var rng = RandomNumberGenerator.new()
enum State {STATE_IDLE, STATE_WALK, STATE_PICKED, STATE_RUN, STATE_THROWN}
var state: State = State.STATE_IDLE
var walk_dir: Vector2 = Vector2.ZERO
var last_dir: int = 1


@export var min_run_dist = 200
@export var max_run_dist = 250

@export var walk_speed = 150
@export var run_speed = 500

@export var drag_damp = 40
@export var normal_damp = 4
@export var thrown_damp = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(rand_walk_timer)
	rand_walk_timer.one_shot = true;
	rand_walk_timer.connect("timeout", _on_timer_timeout)
	init_timer()
	
func init_timer():
	if state == State.STATE_IDLE:
		var rand_time = max(0, rng.randfn(4, 1.5))
		rand_walk_timer.start(rand_time)
	elif state == State.STATE_WALK:
		rand_walk_timer.start(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	gravity_scale = 0
	var curr_mpos = get_viewport().get_mouse_position()
	
	if state == State.STATE_PICKED and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pick_down()
	if state == State.STATE_THROWN and linear_velocity.length() < 1:
		state = State.STATE_WALK
		init_timer()
	
	var mouse_dis = position.distance_to(curr_mpos)
	if (state == State.STATE_IDLE or state == State.STATE_WALK) and mouse_dis < min_run_dist:
		# Run away from mouse
		state = State.STATE_RUN
		rand_walk_timer.stop()
	elif state == State.STATE_RUN and mouse_dis > max_run_dist:
		state = State.STATE_IDLE
		init_timer()
	
	var force = Vector2.ZERO
	
	if state == State.STATE_WALK:
		force = walk_speed * walk_dir
	elif state == State.STATE_RUN:
		var run_dir = -position.direction_to(curr_mpos)
		force = run_speed * run_dir
	elif state == State.STATE_PICKED:
		var dest_position = initial_self_position +  (curr_mpos - initial_mouse_position)
		apply_central_force(50 * (dest_position - position) * dest_position.distance_to(position) * delta)
	else:
		pass
	
	if force.length_squared() > 0.001:
		apply_central_force(force)
		last_dir = sign(force.dot(Vector2.LEFT))
	
	scale.x = last_dir
		
	if state == State.STATE_PICKED:
		linear_damp = drag_damp
	elif state == State.STATE_THROWN:
		linear_damp = thrown_damp
	else:
		linear_damp = normal_damp


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var was_picked_up = state == State.STATE_PICKED
		var is_picked_up = event.pressed
		initial_mouse_position = event.position
		initial_self_position = position
		
		if not was_picked_up and is_picked_up:
			state = State.STATE_PICKED
			rand_walk_timer.stop()
		elif was_picked_up and not is_picked_up:
			pick_down()

func pick_down():
	state = State.STATE_THROWN
	init_timer()
	

func _on_timer_timeout():
	if state == State.STATE_IDLE:
		state = State.STATE_WALK
		walk_dir = Vector2.from_angle(rng.randf_range(0, 2*PI))
	elif state == State.STATE_WALK:
		state = State.STATE_IDLE
	init_timer()
	
	
