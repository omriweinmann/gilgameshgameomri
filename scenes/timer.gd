extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")

var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var health: int = 3

var stars = 15

var rng := RandomNumberGenerator.new()

func _on_timer_timeout() -> void:
	#print("meteor")
	var meteor = meteor_scene.instantiate()
	
	$Meteors.add_child(meteor)
	
	meteor.connect('collision', _on_meteor_collision)

func _on_meteor_collision():
	#print("HeyGuys!")
	health -= 1
	get_tree().call_group('ui','_set_health', health)
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
		#print("Booo")

func _on_player_laser(pos) -> void:
	#print(pos)
	var laser = laser_scene.instantiate()
	
	$Lasers.add_child(laser)
	laser.position = pos
	
	#print(laser.position)

func _ready():
	get_tree().call_group('ui','_set_health', health)
	
	for n in stars+1:
		var new_star = $BG/Stars/StarAnimated.duplicate()
		
		$BG/Stars.add_child(new_star)
		var r_pos = rng.randf_range(0.0,1.0)
		var r_pos2 = rng.randf_range(0.0,1.0)
		new_star.position = Vector2(get_viewport().get_visible_rect().size[0]*r_pos, get_viewport().get_visible_rect().size[1]*r_pos2)
		new_star.play("default", rng.randf_range(0,1))
		var r_size = rng.randf_range(0.5,1.5)/10
		new_star.scale = Vector2(r_size,r_size)
