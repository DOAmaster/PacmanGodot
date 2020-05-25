extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	MyGlobals.powerUpActive = 0
	MyGlobals.score = 0
	MyGlobals.lifes = 3
	#set up game over 
	MyGlobals.gameOver = 0
	get_node("GameOverText").visible = false
	
	#displays first score
	get_node("Score/ScoreNumber").text = str(MyGlobals.score)
	
	#displays life
	displayLife()
	
	
	
	newStage()
	
	pass # Replace with function body.

#calls when a pickUp is touched, checks if all pick ups are not visable to win
func checkWin():
	var hasWin = 1
	var pickUps = get_tree().get_nodes_in_group("pickUp")
	for i in pickUps:
		if(i.visible == true):
			hasWin = 0
	if(hasWin == 1):
		var tempLevel = MyGlobals.level + 1
		MyGlobals.level = tempLevel
		print("stage win")
		resetStage2()
	pass

#calls on new game, refreshes the pickups and level++
func newStage():
	#remask reshow pickups
	var pickUps = get_tree().get_nodes_in_group("pickUp")
	for i in pickUps:
		i.visible = true
		i.get_node("Area2D").set_collision_layer_bit(0,1)
		i.get_node("Area2D").set_collision_mask_bit(0,1)
	#get_node("GhostSpawn").position

#called when stage won
func resetStage2():
		#reposition Player
		var playerLoc = get_node("PlayerSpawn").position
		get_node("Player").position = playerLoc
		get_node("Player").lastDir = ""
		
		#repositions ghosts
		var ghostLoc = get_node("GhostSpawn").position
		var ghosts = get_tree().get_nodes_in_group("Ghost")
		for i in ghosts:
			i.position = ghostLoc
		#get_node("GhostSpawn").position
		
		#refresh pickUps twice, sloppy fix for spawning missing pickup bug
		newStage()
		$PickupTimer.start()


#called when touched by ghost, reset positions if have life
func resetStage():
	#remove life
	var tempLife = MyGlobals.lifes - 1
	if (tempLife < 0):
		MyGlobals.gameOver = 1
		get_node("GameOverText").visible = true
		get_node("GameOverText/ReplayButton").grab_focus()
	else:
		MyGlobals.lifes = tempLife
		displayLife()
		
		#repositions ghosts
		var ghostLoc = get_node("GhostSpawn").position
		var ghosts = get_tree().get_nodes_in_group("Ghost")
		for i in ghosts:
			i.position = ghostLoc
		#get_node("GhostSpawn").position
		
		
		#reposition Player
		var playerLoc = get_node("PlayerSpawn").position
		get_node("Player").position = playerLoc
		get_node("Player").lastDir = ""
		
		#refresh pickUps
		#newStage()

func displayLife():
	get_node("life0").visible = false
	get_node("life1").visible = false
	get_node("life2").visible = false
	get_node("life3").visible = false
	get_node("life4").visible = false
	match MyGlobals.lifes:
		0:
			get_node("life0").visible = false
			get_node("life1").visible = false
			get_node("life2").visible = false
			get_node("life3").visible = false
			get_node("life4").visible = false
		1:
			get_node("life0").visible = true
		2:
			get_node("life0").visible = true
			get_node("life1").visible = true
		3:
			get_node("life0").visible = true
			get_node("life1").visible = true
			get_node("life2").visible = true
		4:
			get_node("life0").visible = true
			get_node("life1").visible = true
			get_node("life2").visible = true
			get_node("life3").visible = true
		5:
			get_node("life0").visible = true
			get_node("life1").visible = true
			get_node("life2").visible = true
			get_node("life3").visible = true
			get_node("life4").visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Score/ScoreNumber").text = str(MyGlobals.score)
	get_node("HighScore/HighScoreNumber").text = str(MyGlobals.score)
	pass


func _on_GhostCage_body_entered(body):
	if body.is_in_group("Ghost"):
		body.isCaged = true
		#var tempScore = MyGlobals.score + 50
		#MyGlobals.score = tempScore
		#queue_free()
	pass # Replace with function body.


func _on_GhostCage_body_exited(body):
	if body.is_in_group("Ghost"):
		body.isCaged = false
	#var tempScore = MyGlobals.score + 50
	#MyGlobals.score = tempScore
	#queue_free()
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.is_in_group("Ghost"):
		body.moveUp()
	pass # Replace with function body.


func _on_ReplayButton_pressed():
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.

#resume game when stage is setup
func _on_PickupTimer_timeout():
	newStage()
	pass # Replace with function body.

func setPowerUp():
	#repositions ghosts
	#var ghostLoc = get_node("GhostSpawn").position
	var ghosts = get_tree().get_nodes_in_group("Ghost")
	for i in ghosts:
		i.set_modulate(Color(0,0,1))
	#get_node("GhostSpawn").position

func unsetPowerUp():
	var ghosts = get_tree().get_nodes_in_group("Ghost")
	for i in ghosts:
		i.set_modulate(Color(1,1,1))

func _on_PowerupTimer_timeout():
	MyGlobals.powerUpActive = 0
	unsetPowerUp()
	pass # Replace with function body.
