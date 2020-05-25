extends KinematicBody2D

export (int) var speed = 50
var slowSpeed = 25
var rng = RandomNumberGenerator.new()

var isMoving = 0
var lastDir = "left"
var velocity = Vector2()
var my_random_number = 3
var isCaged = 0
var forceMoving = 0
var player
var chasing = 0

func _ready():
	player = get_node("../Player")
	rng.randomize()
	newDir()
	

func newDir():
	my_random_number = rng.randi_range(1, 4)
	match my_random_number:
		1:
			lastDir = "up"
		2:
			lastDir = "down"
		3:
			lastDir = "left"
		4:
			lastDir = "right"
	pass


func get_direction():
	#velocity = Vector2()
	if (lastDir == "right"):
		isMoving = 1
		lastDir = "right"
		velocity.x += 1
	if (lastDir == "left"):
		isMoving = 1
		lastDir = "left"
		velocity.x -= 1
	if (lastDir == "down"):
		isMoving = 1
		lastDir = "down"
		velocity.y += 1
	if (lastDir == "up"):
		isMoving = 1
		lastDir = "up"
		velocity.y -= 1
	if(!MyGlobals.powerUpActive):
		velocity = velocity.normalized() * speed
	else:
		velocity = velocity.normalized() * slowSpeed

func moveUp():
	$EscapeTimer.start()
	velocity.x = 0
	velocity.y = 0
	forceMoving = 1
	lastDir = "up"

func _physics_process(delta):
	if (!move_and_slide(velocity) && forceMoving == 0):
		#print("not moving")
		newDir()
	if(forceMoving):
		velocity.y -= 1
		velocity = move_and_slide(velocity)
	else:
		get_direction()
	#make ghost focus player position, TODO wall check
	if(chasing && !isCaged):
		if(!MyGlobals.powerUpActive):
			velocity = velocity.normalized() * speed
		else:
			velocity = velocity.normalized() * slowSpeed
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		print("player hit")
		if(!MyGlobals.powerUpActive):
			get_node("..").resetStage()
		else:
			print("eating ghost")
		#queue_free()
	pass # Replace with function body.


func _on_EscapeTimer_timeout():
	forceMoving = 0
	pass # Replace with function body.
								

func _on_chasearea1_body_entered(body):
	if body.is_in_group("Player"):
		print("player chase")
		chasing = 1
	pass # Replace with function body.


func _on_chasearea1_body_exited(body):
	if body.is_in_group("Player"):
		print("player no chase")
		chasing = 0
	pass # Replace with function body.


func _on_chasearea2_body_entered(body):
	if body.is_in_group("Player"):
		print("player chase")
		chasing = 1
	pass # Replace with function body.


func _on_chasearea2_body_exited(body):
	if body.is_in_group("Player"):
		print("player no chase")
		chasing = 0
	pass # Replace with function body.
