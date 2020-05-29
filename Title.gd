extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var storedScore

const FILE_NAME = "user://game-data.json"

var player = {
	"hscore": 0,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	loadf()
	MyGlobals.savedHighScore = player.hscore
	
	get_node("HighScore/HighScoreNumber").text = str(MyGlobals.savedHighScore)
	
	#displays first score
	get_node("Score/ScoreNumber").text = str(MyGlobals.score)
	
	pass # Replace with function body.

func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(player))
	file.close()

func loadf():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

func _input(event):
	if event is InputEventKey and event.pressed:
		print("loading")
		get_tree().change_scene("res://Game.tscn")
		#if event.scancode != KEY_ENTER:
			#pass


func _on_Button_pressed():
	get_tree().change_scene("res://Game.tscn")
	pass # Replace with function body.


func _on_Button2_pressed():
	OS.shell_open("https://doamaster.itch.io/")
	pass # Replace with function body.
