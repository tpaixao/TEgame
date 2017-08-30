extends Area2D

# contants
onready var T_TE = 10; # time to create a new protein
var time_ellapsed;
var id;
var angle;

signal segment_state_changed(old_state,new_state);

enum SEG_STATE {EMPTY, TE, CDS};
onready var state=SEG_STATE.EMPTY
# scenes to preload
onready var protein_scn = preload("res://protein.tscn");

func _process(delta):
	# if TE -> produce new TEs
	if state==SEG_STATE.TE:
		time_ellapsed+=delta;
		#print("process: ",time_ellapsed);
		if time_ellapsed >= T_TE:
			# create a new TE
			#print("creating a new protein")
			var new_protein = protein_scn.instance();
			new_protein.set_pos(Vector2(0,30));
			add_child(new_protein); # this is not correct...
			# new_protein.rotate(-angle)
			var dir = (get_parent().get_global_pos() - get_global_pos()).normalized()
			#new_protein.start_drag(dir);
			time_ellapsed = 0;
			pass
		pass
	# if CDS ->
	# if Empty -> 
	pass

func change_state(new_state):
	if new_state == SEG_STATE.TE:
		time_ellapsed = 0;
		# set sprite
		get_node("Sprite").set_modulate(Color(1,0,0))
		pass
	if new_state == SEG_STATE.CDS:
		get_node("Sprite").set_modulate(Color(0,1,0))
	emit_signal("segment_state_changed",state,new_state);
	print("emmiting signal")
	state = new_state;
	pass

func _ready():
	state = SEG_STATE.EMPTY;
	time_ellapsed = 0;
	set_process(true);
	pass


func _on_Segment5_body_enter(body_id, body,body_shape , area_shape):
	body.attach_to_segment(self)
	#var rot = get_rot();
	#body.start_drag(Vector2(0,1).rotated(rot))
	#print("something entered")
	pass
