extends Label

onready var timer;
signal out_of_time;

var current_time;
var max_time=100;

func _ready():
	current_time = max_time
	set_text(str(current_time))
	
	timer = get_node("Timer");
	timer.start()
	pass

func reset_timer(_max_time):
	max_time = _max_time;
	current_time = max_time;
	
	timer.start();
	pass

func _on_Timer_timeout():# everytime the counter decreases by one
	current_time-=1;
	set_text(str(current_time));
	if current_time<10: # change font color to red?
		pass
	if current_time <= 0: # time has runout.
		emit_signal("out_of_time")
		pass
	pass
