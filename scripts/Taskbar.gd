extends Control

@onready var pet = get_node("../Pet")
@onready var play_menu = $PlayMenu
@export var frames = ResourceLoader.load("res://animation.tres")
var debug_window =  preload("res://scenes/ControlDebugWindow.tscn")
var following = false
var dragging_start_position : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().set_embedding_subwindows(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if following:
		DisplayServer.window_set_position(Vector2(DisplayServer.window_get_position()) + get_global_mouse_position() - dragging_start_position-Vector2(0,300))

func open_debug():
	get_parent().add_child(debug_window.instantiate())

func _on_movement_icon_gui_input(event):
	if event is InputEventMouseButton:
		if event.get_button_index() == 1 and event.is_pressed():
			following = true
			dragging_start_position = get_local_mouse_position()
		elif event.get_button_index() == 1 and !event.is_pressed():
			following = false

func _on_play_button_pressed():
	pet.anim.play("item_appear")

func _on_close_button_pressed():
	get_tree().quit()

