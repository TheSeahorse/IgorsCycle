extends Node2D

var player_center: Node
var beam_on = true
var player_on_beam = false

func _ready():
	player_center = $Player.get_cycle_body()
	$Camera2D.make_current()


func _process(delta):
	$Camera2D.position = player_center.position  + $Player.position + Vector2(100, -50)
	if player_on_beam and beam_on:
		$Player.abducted()

func _on_Beam_Timer_timeout():
	if beam_on:
		beam_on = false
		$Ufo/Beam.hide()
	else:
		beam_on = true
		$Ufo/Beam.show()


func _on_Area2D_body_entered(body):
	player_on_beam = true


func _on_Area2D_body_exited(body):
	player_on_beam = false
