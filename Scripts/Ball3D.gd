extends Node2D

var player_center: Node
var goals

func _ready():
	goals = get_parent().goals
	player_center = $Player.get_cycle_body()
	$Camera2D.make_current()
	$Ball3DStriker.set_ball($Ball)
	$Ball3DMidfielder.set_ball($Ball)
	$CanvasLayer/Score.set_text(str(goals) + " - " + "2")


func _process(delta):
	$Camera2D.position = player_center.position  + $Player.position + Vector2(250, -100)


func _on_AwayGoal_goal():
	get_parent().restart_score()


func _on_HomeGoal_goal():
	get_parent().restart()
