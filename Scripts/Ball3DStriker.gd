extends KinematicBody2D

var velocity = Vector2(0,0)
var gravity = 10
var speed = 40
var new_dir = Vector2(0,0)
var Ball: RigidBody2D

var names = ["TeamSoloKappa", "arashU", "EddieHD", "xbeast20", "WubenU", "!WAF! olisiaaa"]
# names = TeamSoloKappa, arash, EddieHD, xbeast20, WubenU, !WAF! olisiaaa

func _ready():
	$Name.set_text(get_random_name())


func get_random_name() -> String:
	return names[randi() % names.size()]


func set_ball(ball):
	Ball = ball


func _physics_process(delta):
	if is_instance_valid(Ball):
		if self.position.x > Ball.position.x:
			new_dir.x = abs(new_dir.x) * -1
		else:
			new_dir.x = abs(new_dir.x)
	velocity += new_dir
	if new_dir.x == 0:
		velocity.x *= 0.95
	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP, true)
	new_dir = Vector2(0,0)


func _input(event):
	if event.is_action_pressed("back_up") or event.is_action_pressed("front_up"):
		new_dir += Vector2(0,-speed*2)
	elif event.is_action_pressed("back_left") or event.is_action_pressed("front_left"):
		new_dir += Vector2(speed,0)
	elif event.is_action_pressed("back_right") or event.is_action_pressed("front_right"):
		new_dir += Vector2(-speed,0)


