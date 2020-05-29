extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		print("fruit picked up")
		var tempScore
		match MyGlobals.level:
			1:
				tempScore = MyGlobals.score + 100
			2:
				tempScore = MyGlobals.score + 300
			3:
				tempScore = MyGlobals.score + 500
			4:
				tempScore = MyGlobals.score + 700
			5:
				tempScore = MyGlobals.score + 1000
			6:
				tempScore = MyGlobals.score + 2000
			7:
				tempScore = MyGlobals.score + 3000
			_:
				tempScore = MyGlobals.score + 3000
		MyGlobals.score = tempScore
		self.visible = false
		$Area2D.set_collision_layer_bit(0,0)
		$Area2D.set_collision_mask_bit(0,0)
		
		get_parent().get_node("fruitSound").play()
		
	pass # Replace with function body.
