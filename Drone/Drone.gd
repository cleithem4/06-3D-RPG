extends KinematicBody

var radius = 50
var angle = 0
export var height = 20
export var speed = 5
var health = 100

func _ready():
	randomize()
	angle = randf() * PI * 2
	new_position(angle)
	
func new_position(a):
	var pos = Vector3(0,height,0)
	pos.x = radius * cos(a)
	pos.z = radius * sin(a)
	look_at(pos,Vector3(0,1,0))
	$Tween.interpolate_property(self,"global_transform:origin",global_transform.origin,pos,speed,Tween.TRANS_EXPO,Tween.EASE_IN_OUT)
	$Tween.start()
func _physics_process(delta):
	if get_node("/root/Game/Target_container").get_child_count() == 0:
		$Sprite3D.show()
	else:
		$Sprite3D.hide()

func _on_Tween_tween_all_completed():
	angle += PI/2 + (randf() * (PI/2))
	angle = wrapf(angle,0, 2* PI)
	new_position(angle)
	


func _on_Area_body_entered(body):
	if body.name == "Player":
		body.damage()

func die():
	if get_node("/root/Game/Target_container").get_child_count() == 0:
		health -= 10
		if health <= 5:
			Global.update_score(100)
			get_tree().change_scene("res://UI/Win.tscn")
			
