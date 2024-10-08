extends Node2D

onready var topui = $TopUi
onready var player_controller = $YSort/player/Controller
onready var pause_ui = $TopUi/pause_menu/pause_menu/Panel
onready var resume = $TopUi/pause_menu/pause_menu/Panel/VBoxContainer/resume as Button
onready var player = $YSort/player
onready var player_controller_joystick = $YSort/player/Controller/joystick
onready var place_name = $TopUi/Label2
var current_map = "res://levels/Chapter2_maps/classoriaMain.tscn"
var starting_player_position = Vector2  (160, 33)
var bat_ids_to_check = ["demon1", "demon2","demon3","demon4","demon5","demon6","demon7","demon8","demon9","demon10","stone1","stone2","stone3","stone4"] 


# Called when the node enters the scene tree for the first time.
func _ready():
	set_overall_initial_position()
	set_player_position()
	
	place_name.text = "Classoria Market Center"
	resume.connect("pressed", self, "resume_the_game")
	Global.set_map(current_map)
	GlobalCanvasModulate.apply_trigger("night")
	Musicmanager.set_music_path("res://Music and Sounds/bg music/deadnight.wav")


func set_player_position():
	if Global.get_player_initial_position() == Vector2(0, 0):
		Global.set_player_current_position(starting_player_position)
		print("1")
	elif int(Dialogic.get_variable("gandalf")) == 9:
		player_controller.hide()
		player_controller_joystick.disable_joystick()
		var new_dialog = Dialogic.start('starter1')
		add_child(new_dialog)
		new_dialog.connect("timeline_end", self, "end_intructions")
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
		player.global_position = Global.get_player_current_position()

func set_overall_initial_position():
	Global.set_player_initial_position(Global.get_player_current_position())

func end_intructions(timelineend):
	player_controller.show()
	player_controller_joystick.enable_joystick()

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


############## interactions ################




func _on_Area2D_body_shape_enteredbug1(body_rid, body, body_shape_index, local_shape_index):
	Global2.set_question(0, "Which loop guarantees that the code inside will run at least once, even if the condition is false initially?")
	Global2.set_answers(0, "While loop")
	Global2.set_answers(1, "Do-while loop")
	Global2.set_answers(2, "For loop")
	Global2.set_answers(3, "None of the above")
	Global2.set_feedback(0, "Incorrect. A while loop checks the condition before running the code.")
	Global2.set_feedback(1, "Correct! A do-while loop runs the code block at least once.")
	Global2.set_feedback(2, "Incorrect. A for loop also checks the condition before executing the code.")
	Global2.set_feedback(3, "Incorrect. The do-while loop guarantees at least one execution.")
	
	
	Global2.set_question(1, "Which loop is best suited for iterating a specific number of times?")
	Global2.set_answers(4, "While loop")
	Global2.set_answers(5, "Do-while loop")
	Global2.set_answers(6, "For loop")
	Global2.set_answers(7, "None of the above")
	Global2.set_feedback(4, "Incorrect. A while loop is more flexible for unknown iterations. Consider the loop that is structured for a known count.")
	Global2.set_feedback(5, "Incorrect. A do-while loop still depends on a condition and may not limit iterations.")
	Global2.set_feedback(6, "Correct! The for loop is ideal for scenarios with a predefined number of iterations.")
	Global2.set_feedback(7, "Incorrect. An infinite loop doesn't stop and isn't used for specific counts. Think about loops with clear starting and ending points.")
	
	
	Global2.set_question(2, "In which loop is the condition checked after the execution of the code block?")
	Global2.set_answers(8, "While loop")
	Global2.set_answers(9, "Do-while loop")
	Global2.set_answers(10, "For loop")
	Global2.set_answers(11, "None of the above")
	Global2.set_feedback(8, "Incorrect. The condition is checked before running the code block. Think about which loop allows for post-condition checks.")
	Global2.set_feedback(9, "Incorrect. A for loop checks the condition before each iteration, not after.")
	Global2.set_feedback(10, "Correct! This loop checks the condition after executing the code block.")
	Global2.set_feedback(11, "Incorrect. The do-while loop is specifically designed for this purpose.")
	
	
	Global2.set_question(3, "Which loop can run continuously if the condition is not properly defined?")
	Global2.set_answers(12, "For loop")
	Global2.set_answers(13, "Do-while loop")
	Global2.set_answers(14, "While loop")
	Global2.set_answers(15, "All of the above")
	Global2.set_feedback(12, "Incorrect. A for loop can run indefinitely if the condition is always true. Consider all loop types.")
	Global2.set_feedback(13, "Incorrect. A do-while loop can also run indefinitely based on its condition.")
	Global2.set_feedback(14, "Incorrect. A while loop can run indefinitely if the condition is never false.")
	Global2.set_feedback(15, "Correct! Any of these loops can run indefinitely with a mismanaged condition.")
	
	
	Global2.set_question(4, "What will happen if the condition of a while loop is never false?")
	Global2.set_answers(16, "run once")
	Global2.set_answers(17, "run contonuously")
	Global2.set_answers(18, "not run")
	Global2.set_answers(19, "None")
	Global2.set_feedback(16, "Incorrect. It will keep running as long as the condition is true.")
	Global2.set_feedback(17, "Correct! If the condition remains true, the loop will never stop.")
	Global2.set_feedback(18, "Incorrect. It runs if the condition is true.")
	Global2.set_feedback(19, "Incorrect. The correct answer is that it will run indefinitely.")
	
	
	Global.load_game_position = true
	Global2.load_enemy_data("res://Battlescenes/tres/bat2.tres")
	Global2.correct_answer_ch1_2 = true
	Global2.correct_answer_ch2_3 = true
	Global2.correct_answer_ch3_3 = true
	Global2.correct_answer_ch4_4 = true
	Global2.correct_answer_ch5_2 = true
	Global2.dialogue_name = "bug5"
	print("quiz on bug 2 is activated")
	
	SceneTransition.change_scene("res://intro/question_panel_withbugs.tscn")
