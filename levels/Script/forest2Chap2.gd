extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
onready var slime1_sprite =  $YSort/bats/Slime1
onready var slime2_sprite = $YSort/bats/Slime2
onready var slime2_dectectionzone = $YSort/bats/Slime2/PlayerDetectionZone/CollisionShape2D
onready var slime1_dectectionzone = $YSort/bats/Slime1/PlayerDetectionZone/CollisionShape2D
onready var slime1_question = $YSort/bats/Slime1/quiz/CollisionShape2D
onready var slime2_question = $YSort/bats/Slime2/quiz/CollisionShape2D
onready var slime2_hitbox_collision = $YSort/bats/Slime2/Hitbox/CollisionShape2D
onready var slime1_hitbox_collision = $YSort/bats/Slime1/Hitbox/CollisionShape2D

onready var bat13 = $YSort/bats/Bat13
onready var bat14 = $YSort/bats/Bat14

onready var path_gandalgoutside = $gandalfHouse_Outside/CollisionShape2D
onready var path_classoria = $classoria_Gates/CollisionShape2D
onready var arrow_classoria = $path_arrow_classoria
onready var arrow_gandalfoutside = $path_arrow


var current_map = "res://levels/Chapter2_maps/forest2Chap2.tscn"
var starting_player_position = Vector2  (160, 33)



# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_appearance()
	slime_appearance()
	path_to_classoria()
	#GlobalCanvasModulate.apply_trigger("night")
	morning_setup()
	set_overall_initial_position()
	set_player_position()
	place_name.text = "Way to the clasoria"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	Musicmanager.set_music_path("res://Music and Sounds/bg music/guildInside.wav")
func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif Global.from_level != null && Global.load_game_position == true:
		player.global_position = Global.get_player_current_position()
		Global.load_game_position = false
		print("2")
	elif Global.from_level != null:
		var target_node_path = Global.from_level + "_pos"
		if has_node(target_node_path):
			var target_node = get_node(target_node_path)
			player.global_position = target_node.position
			#print("Player position set from ", target_node_path)
		else:
			pass
			#print("Player position set from ", target_node_path)
	else:
		print("3")
		Global.load_game_position = false
		player.global_position = Global.get_player_current_position()

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())


func resume_the_game() -> void:
	get_tree().paused = false
	topui.visible = true
	player_controller.visible = true
	pause_ui.hide()

func _on_pause_game_pressed():
	get_tree().paused = true
	topui.visible = false
	player_controller.visible = false
	pause_ui.show()
####################################
func morning_setup():
	if int(Dialogic.get_variable("gandalf")) == 4 or int(Dialogic.get_variable("gandalf")) == 5 or int(Dialogic.get_variable("gandalf")) == 6:
		GlobalCanvasModulate.apply_trigger("morning")
	elif int(Dialogic.get_variable("gandalf")) == 7 or int(Dialogic.get_variable("gandalf")) == 8 or Global2.is_badge_complete("badge20"):
		GlobalCanvasModulate.apply_trigger("night")
	else:
		print("dialogic gandalf")
######################################
func path_to_classoria():
	if Global2.is_badge_complete("badge20"):
		path_classoria.disabled = false
		arrow_classoria.show()
		path_gandalgoutside.disabled = true
		arrow_gandalfoutside.hide()
	else:
		path_classoria.disabled = true
		arrow_classoria.hide()
		#path_gandalgoutside.disabled = true
		#arrow_gandalfoutside.hide()
		

func enemy_appearance():
	if int(Dialogic.get_variable("gandalf")) != 7:
		bat13.queue_free()
		bat14.queue_free()
	else:
		print("gandalf 7 is not yet activated")

func slime_appearance():
	if int(Dialogic.get_variable("gandalf")) != 7:
		slime1_sprite.hide()
		slime1_dectectionzone.disabled = true
		slime2_sprite.hide()
		slime2_dectectionzone.disabled = true
		slime1_question.disabled = true
		slime2_question.disabled = true
		slime1_hitbox_collision.disabled = true
		slime2_hitbox_collision.disabled = true
	else:
		path_gandalgoutside.disabled = true
		arrow_gandalfoutside.hide()
		arrow_classoria.show()
		slime1_sprite.show()
		slime1_dectectionzone.disabled = false
		slime2_sprite.show()
		slime2_dectectionzone.disabled = false
		slime1_question.disabled = false
		slime2_question.disabled = false
		slime1_hitbox_collision.disabled = true
		slime2_hitbox_collision.disabled = true

############## interactions ################


func _on_quiz_body_shape_entered_slime2(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "You’re facing a Slime bug! Which part of the switch statement will run? \n string bugType = 'bug';")
	Global2.set_answers(0, "case bug")
	Global2.set_answers(1, "default")
	Global2.set_answers(2, "none")
	Global2.set_answers(3, "case glitch")
	Global2.set_feedback(0, "Correct! The case bug block will run if it matches the condition.")
	Global2.set_feedback(1, "Incorrect. Default runs only if none of the cases match.")
	Global2.set_feedback(2, "Incorrect. The switch statement must match a case or run the default.")
	Global2.set_feedback(3, "Incorrect. Case glitch would run if the condition matched 'glitch,' not 'bug.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/switch/Switch.png")
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/slime.tres")
	Global2.correct_answer_ch1_1 = true
	Global2.dialogue_name = "bug3"
	print("quiz on bug 2 is activated")
	
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")

func _on_quiz_body_shape_entered_slime1(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "You’re facing a Slime bug! Which part of the switch statement will run? \n string bugType = 'default';")
	Global2.set_answers(0, "case bug")
	Global2.set_answers(1, "default")
	Global2.set_answers(2, "none")
	Global2.set_answers(3, "case glitch")
	Global2.set_feedback(0, "Incorrect! The case bug block will only run if it matches the condition.")
	Global2.set_feedback(1, "Correct!. Default runs if none of the cases match.")
	Global2.set_feedback(2, "Incorrect. The switch statement must match a case or run the default.")
	Global2.set_feedback(3, "Incorrect. Case glitch would run if the condition matched 'glitch,' not 'bug.")
	Global2.set_picture_path(0,"res://intro/picture/question/chapter2/switch/Switch.png")
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/slime.tres")
	Global2.correct_answer_ch1_2 = true
	Global2.dialogue_name = "bug4"
	print("quiz on bug 2 is activated")
	
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")
