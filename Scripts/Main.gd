extends Node2D

const Level1 = preload("res://Scripts/BugLevel.tscn")
const Level2 = preload("res://Scripts/RoofTopBar.tscn")
const Level3 = preload("res://Scripts/Ball3D.tscn")
const Level4 = preload("res://Scripts/TwitchClimb.tscn")


enum {NORMAL, HARD}
var Mode = HARD

var playing := false
var level_playing := 0
var active_level = null
var goals = 0


func _ready():
	randomize()

func _input(event):
	if event.is_action_pressed("quit"):
		if playing:
			back_to_menu()
		else:
			get_tree().quit()
	if event.is_action_pressed("restart") and playing:
		restart()


func get_difficulty() -> int:
	return Mode


func back_to_menu():
	active_level.queue_free()
	for child in $Menu.get_children():
		child.show()
	active_level = null
	playing = false
	level_playing = 0
	goals = 0


func restart():
	goals = 0
	play_level(level_playing)

func restart_score():
	goals += 1
	if goals == 3:
		goals = 0
		play_level(4)
	play_level(level_playing)


func play_level(number: int):
	if is_instance_valid(active_level):
		active_level.queue_free()
	match number:
		1:
			active_level = Level1.instance()
		2:
			active_level = Level2.instance()
		3:
			active_level = Level3.instance()
		4:
			active_level = Level4.instance()
	playing = true
	level_playing = number
	for child in $Menu.get_children():
		child.hide()
	call_deferred("add_child", active_level)


func _on_Level_pressed(number: int):
	play_level(number)
