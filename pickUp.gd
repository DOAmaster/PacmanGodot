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
		#print("pickup")
		var tempScore = MyGlobals.score + 10
		MyGlobals.score = tempScore
		var tempCount = MyGlobals.pickupCount + 1
		MyGlobals.pickupCount = tempCount
		self.visible = false
		$Area2D.set_collision_layer_bit(0,0)
		$Area2D.set_collision_mask_bit(0,0)
		
		#body.set_collision_mask_bit(0,0)
		#body.set_collision_layer_bit(0,0)
		get_parent().checkWin()
		
		get_parent().get_node("chompSound").play()
		#queue_free()
	pass # Replace with function body.
