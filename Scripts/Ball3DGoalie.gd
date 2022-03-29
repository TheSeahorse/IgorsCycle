extends Path2D

var speed = 2

var names = ["VeezaQ", "p4ul3", "Whiskas_U", "xqcL", "xeux", "catshit"]
#names = veezaQ, p4ul3, whiskas, xqcL, xeux


func _ready():
	$PathFollow2D/KinematicBody2D/Name.set_text(get_random_name())


func get_random_name() -> String:
	return names[randi() % names.size()]


func _physics_process(delta):
	$PathFollow2D.set_offset($PathFollow2D.get_offset() + speed)
