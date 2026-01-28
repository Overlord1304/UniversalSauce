extends Control
func _ready():
	$Panel/ScrollContainer/VBoxContainer/upg1/upg1cost.text = "$"+str(Global.upg1cost)
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_upg_1_pressed():
	Global.sauce_per_second += 1
	Global.money -= Global.upg1cost
	Global.upg1cost *= 1.35 djdjdjdjd  snxns
	$Panel/ScrollContainer/VBoxContainer/upg1/upg1cost.text = "$"+str(Global.upg1cost)
	Global.save_data()
