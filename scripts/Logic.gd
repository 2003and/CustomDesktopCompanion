extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var taskbar = get_node("../Taskbar")
@onready var appear_button = taskbar.get_node("AppearButton")


func _ready():
	var anim_stack = FileAccess.open("_task_stack", FileAccess.READ)
	print(anim_stack)
	# Set the playing animation to "idle"
	anim.play("idle")
	
	# Make clicks pass through everything but the taskbar 
	DisplayServer.window_set_mouse_passthrough([
		Vector2(0,300),
		Vector2(300,300),
		Vector2(300,340),
		Vector2(0,340),])
	
	# Set window always on top by default
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, true) 
	
	# Connect various signals
	appear_button.pressed.connect(_item_appear_signal)


func _process(delta):
	pass
#	if anim_stack.get_position() < anim_stack.get_length():
#		var tmp = anim_stack.get_line()
#	OS.execute("head", ["-n 1","/home/andrew/Godot/Spirit-clone/_task_stack"], tmp) # todo: fix freezing the 
#	var a
#	if tmp[0]:
#		a = tmp[0]
#		print(a)


func _item_appear_signal():
	# Open the debug console window
	taskbar.open_debug()


func _on_animated_sprite_2d_animation_finished():
	# Switch to item spinning when item has finished appearing
	if anim.animation == "item_appear": 
		anim.play("item_spin")
	# Switch to idle animation when item has finished disappearing
	elif anim.animation == "item_delete": 
		anim.play("idle")
