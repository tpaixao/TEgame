extends Node2D

onready var fitness=0;
onready var max_fitness=0;
onready var score=0;

#get the size right...
onready var seg5_scn = preload("res://Segment5.tscn");
onready var fitness_bar = get_node("FitnessBar");
var seg_states; # to keep the enum of segment states
var radius;
var n_segs;

var segments = [];


func place_segment(radial_pos):
	var seg5 = seg5_scn.instance();
	seg_states = seg5.SEG_STATE;
	seg5.set_scale(Vector2(.85,.85)); #this will have to be fixed when I get better sprites
	seg5.set_pos(Vector2(radius*cos(radial_pos),-radius*sin(radial_pos)));
	seg5.rotate(-PI/2+radial_pos);
	seg5.angle = -PI/2+radial_pos;
	seg5.id = segments.size();
	# connect signals
	seg5.connect("segment_state_changed",self,"on_segment_change");
	segments.append(seg5);
	add_child(seg5);
	pass

func on_segment_change(old_state,new_state):
	print("signal received")
	if old_state == seg_states.EMPTY:
		if new_state == seg_states.TE:
			# increase score
			score+=1
			pass
		if new_state == seg_states.EMPTY:
			fitness+=1;
			pass
	if old_state == seg_states.CDS:
		# decrease fitness
		fitness-=1;
		pass
	fitness_bar.set_val(float(fitness)/float(max_fitness));
	pass

func count_segments(seg_type):
	var count = 0;
	for seg in segments:
		if seg.state == seg_type:
			count+=1
	return count

func _ready():
	radius = 250;
	n_segs = 72;
	max_fitness = 0;
	
	for angle in range(n_segs):
		#print(angle*2*PI*5/360.0)
		place_segment(angle*2*PI*5/360.0)
	#place_segment(PI)
	var seg = segments[20]
	seg.change_state(seg.SEG_STATE.TE)
	# create a bunch of CDSs
	for i in range(n_segs/2):
		var rnd_pos = randi()%n_segs;
		segments[rnd_pos].change_state(segments[rnd_pos].SEG_STATE.CDS)
		
	max_fitness = count_segments(seg_states.CDS);
	fitness= max_fitness;# need to reset it: signals update it...
	score=count_segments(seg_states.TE);
	fitness_bar.set_val(float(fitness)/float(max_fitness));
	pass
