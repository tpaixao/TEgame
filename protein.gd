extends KinematicBody2D

enum STATE{normal,being_dragged,attached}
var state;
var attached_segment;

var max_speed = 100;
var speed_boost = 200;
var speed = 100;
var push_duration= 0.5;
var attach_duration = 1;
var direction;
var time_ellapsed;
#var being_dragged=false;

func start_drag(dir):
	if state == STATE.normal:
		#print("dragging")
		#being_dragged = true;
		state = STATE.being_dragged;
		time_ellapsed = 0;
		direction = dir.normalized();
	pass

func attach_to_segment(segment):
	state = STATE.attached;
	time_ellapsed=0;
	attached_segment = segment;
	pass

func _process(delta):
	#print(delta)
	if state == STATE.normal:
		speed = max_speed;
		random_rotate();
	if state == STATE.being_dragged: #being dragged
		time_ellapsed+=delta;
		speed = max_speed+speed_boost*pow((push_duration-time_ellapsed)/push_duration,2.0);
		if(time_ellapsed>=push_duration):
			state = STATE.normal ;
		pass
	if state == attached: #this should come last (to prevent escape from the ring
		speed = 0;
		time_ellapsed+=delta;
		if(time_ellapsed>attach_duration):#turn segment
			attached_segment.change_state(attached_segment.SEG_STATE.TE);
			queue_free()
		pass
	move(direction * speed * delta)
	pass

func random_rotate():
	direction = (direction.rotated((randf()-.5)*PI)).normalized();
	# update direction
	pass

func _ready():
	direction = Vector2(1,0); 
	state = STATE.normal;
	#being_dragged = false;
	set_process(true)
	pass
