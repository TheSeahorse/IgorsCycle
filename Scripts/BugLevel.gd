extends Node2D

var player_center: Node

func _ready():
	player_center = $Player.get_cycle_body()
	$Camera2D.make_current()


func _process(delta):
	$Camera2D.position = player_center.position  + $Player.position + Vector2(100, -50)

