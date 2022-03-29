extends Area2D


export var level := 0


func _ready():
	match level:
		0:
			pass
		1:
			$bug.show()
		2:
			$bar.show()


func _physics_process(delta):
	$Outline.rotation_degrees += 1


func get_level() -> int:
	return level
