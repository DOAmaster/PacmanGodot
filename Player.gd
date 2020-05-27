extends KinematicBody2D

export (int) var speed = 175

var isMoving = 0
var lastDir = "left"

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if (!MyGlobals.gameOver):
		if (Input.is_action_pressed('ui_right') || (isMoving && lastDir == "right")):
			isMoving = 1
			lastDir = "right"
			velocity.x += 1
			$AnimatedSprite.flip_h = false
		if (Input.is_action_pressed('ui_left') || (isMoving && lastDir == "left")):
			isMoving = 1
			lastDir = "left"
			velocity.x -= 1
			$AnimatedSprite.flip_h = true
		if (Input.is_action_pressed('ui_down') || (isMoving && lastDir == "down")):
			isMoving = 1
			lastDir = "down"
			velocity.y += 1
		if (Input.is_action_pressed('ui_up') || (isMoving && lastDir == "up")):
			isMoving = 1
			lastDir = "up"
			velocity.y -= 1
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2(0,0)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
