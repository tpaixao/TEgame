extends Node2D
var pointer;
var timer;
var pointer_scn;
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _unhandled_input(event):
	if(event.type == InputEvent.MOUSE_BUTTON ):
		if( event.button_index == 1 and event.is_pressed() and not event.is_echo()): #set waypoint
			var mouse_pos = get_global_mouse_pos();
			pointer = pointer_scn.instance();
			add_child(pointer)
			pointer.set_pos(mouse_pos)
	pass


func _ready():
	set_process_unhandled_input(true);
	pointer_scn = preload("res://MouseControl.tscn");
	timer = get_node("Timer")
	timer.connect("out_of_time",self,"_on_out_of_time");
	pass
	
func _on_out_of_time():
	# here we get a new generation (mutation, selection, etc...)
	pass
