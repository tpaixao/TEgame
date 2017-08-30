extends Area2D

var collision_shape;
var radius;
var target_size = 100;

func _ready():
	#set_fixed_process(true);
	pass

func _on_AnimationPlayer_finished():
	queue_free();
	pass # replace with function body

func _on_pointer_body_enter( body ):
	#body.being_dragged = true
	#print("enter")
	var dir = (body.get_global_pos()-get_global_pos());#not normalized
	body.start_drag(dir)
	pass # replace with function body
