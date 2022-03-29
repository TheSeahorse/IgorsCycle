extends Node2D

onready var front_wheel = $FrontWheel
onready var back_wheel = $BackWheel

enum {RIGHT, DOWN, LEFT, UP}
enum {BACK, FRONT}
enum {NORMAL, HARD}
enum {MODE_RIGID, MODE_STATIC, MODE_CHARACTER, MODE_KINEMATIC}

var Speed = 600
var Dead = false
var Mode: int

var main

var dialog_area = null
var dialog_name := ""
var on_dialog := false
var in_dialog := false



func _ready():
	main = get_parent().get_parent()
	Mode = main.get_difficulty()


func _input(event):
	if (Dead and Mode == HARD) or in_dialog:
		return
	if event.is_action_pressed("back_right"):
		push_wheel(BACK, RIGHT)
	elif event.is_action_pressed("back_down"):
		push_wheel(BACK, DOWN)
	elif event.is_action_pressed("back_left"):
		push_wheel(BACK, LEFT)
	elif event.is_action_pressed("back_up"):
		push_wheel(BACK, UP)
	elif event.is_action_pressed("front_right"):
		push_wheel(FRONT, RIGHT)
	elif event.is_action_pressed("front_down"):
		push_wheel(FRONT, DOWN)
	elif event.is_action_pressed("front_left"):
		push_wheel(FRONT, LEFT)
	elif event.is_action_pressed("front_up"):
		push_wheel(FRONT, UP)
	elif event.is_action_pressed("interact") and on_dialog:
		play_dialog()


func play_dialog():
	if not is_instance_valid(dialog_area):
		return
	self.mode = MODE_STATIC
	in_dialog = true
	$E.hide()
	var dialog = Dialogic.start(dialog_area.get_dialog())
	add_child(dialog)
	dialog.connect("timeline_end", self, "dialog_ended", [dialog])
	dialog.connect("dialogic_signal", self, "dialog_answer")


func dialog_ended(_timeline_name, dialog):
	self.mode = MODE_RIGID
	in_dialog = false
	dialog.queue_free()
	$E.show()


func dialog_answer(answer: String):
	match answer:
		"okayeg_increment":
			dialog_area.increment_counter()
		_:
			pass


func push_wheel(wheel: int, direction: int):
	var selected_wheel: RigidBody2D
	if wheel == BACK:
		selected_wheel = back_wheel
	elif wheel == FRONT:
		selected_wheel = front_wheel
	
	match direction:
		RIGHT:
			selected_wheel.apply_central_impulse(Vector2(Speed, 0))
			selected_wheel.apply_torque_impulse(Speed*2)
		DOWN:
			selected_wheel.apply_central_impulse(Vector2(0, Speed/2))
		LEFT:
			selected_wheel.apply_central_impulse(Vector2(-Speed,0))
			selected_wheel.apply_torque_impulse(-Speed*2)
		UP:
			selected_wheel.apply_central_impulse(Vector2(0, -Speed/2))


func get_cycle_body() -> Node:
	return $Body


func check_if_dead():
	if Mode == HARD and not Dead:
		$CollisionShape2D/Blood.show()
		Dead = true
		$DeathTimer.start()


func store_dialog(area):
	dialog_name = area.get_name()
	dialog_area = area
	on_dialog = true
	$E.show()


func remove_dialog():
	dialog_name = ""
	dialog_area = null
	on_dialog = false
	$E.hide()


func abducted():
	check_if_dead()
	$CollisionShape2D/Blood.hide()
	if Dead:
		reverse_gravity()


func reverse_gravity():
	self.gravity_scale = -5
	$BackWheel.gravity_scale = -5
	$FrontWheel.gravity_scale = -5
	$Body.gravity_scale = -5


func _on_Player_body_entered(body):
	if body.get_collision_layer() == 2:
		check_if_dead()


func _on_DeathTimer_timeout():
	main.restart()


func _on_DialogDetector_area_entered(area):
	if Dead:
		return
	if area.get_collision_layer() == 4:
		store_dialog(area)
	elif area.get_collision_layer() == 8:
		main.play_level(area.get_level())


func _on_DialogDetector_area_exited(area):
	if area.get_collision_layer() == 4:
		remove_dialog()
