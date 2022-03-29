extends Area2D

signal goal 

export var home_team := false


func _ready():
	if home_team:
		$Home.show()
		$Away.hide()
	else:
		$Away.show()
		$Home.hide()


func _on_Goal_body_entered(body):
	emit_signal("goal")
