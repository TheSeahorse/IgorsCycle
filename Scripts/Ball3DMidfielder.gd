extends RigidBody2D

var Ball: RigidBody2D
var speed = 7000

var names = ["FarbrorBarbro", "nico___1008", "WaaaMoh", "KingBooMATE", "Epicparsa", "schpetersen"]
#names = FarbrorBarbro, nico___________, WaaaMoh, KingBooMATE, Epicparsa, schpetersen


func _ready():
	$Name.set_text(get_random_name())


func get_random_name() -> String:
	return names[randi() % names.size()]


func set_ball(new_ball: RigidBody2D):
	Ball = new_ball


func impulse_towards_ball():
	if Ball.position.x > 1400:
		var direction = self.position.direction_to(Ball.position)
		self.apply_central_impulse(direction * speed)


func _on_Timer_timeout():
	impulse_towards_ball()
