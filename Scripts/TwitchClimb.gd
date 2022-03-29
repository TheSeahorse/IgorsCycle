extends Node2D

var player_center: Node
var viewers = 0

func _ready():
	player_center = $Player.get_cycle_body()
	$Camera2D.make_current()


func _process(delta):
	$Camera2D.position = player_center.position  + $Player.position + Vector2(0, -100)
	update_viewers()
	$CanvasLayer/Viewers.set_text(str(viewers))


func update_viewers():
	var pos = int(-($Player.position.y)) -74
	if pos < 1000:
		viewers = pos
	elif pos < 2000:
		viewers = 1000 + (pos-1000)*9
	elif pos < 3000:
		viewers = 10000 + (pos-2000)*30
	else:
		viewers = 40000 + (pos-3000)*100
