extends Control
func _ready():
	$Panel/ScrollContainer/VBoxContainer/upg1/upg1cost.text = "$"+str(Global.upg1cost)
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_upg_1_pressed():
	if Global.money >= Global.upg1cost:
		Global.sauce_per_second += 1
		Global.money -= Global.upg1cost
		Global.upg1cost *= 1.35
		$Panel/ScrollContainer/VBoxContainer/upg1/upg1cost.text = "$"+str(Global.upg1cost)
		Global.save_data()



func _on_upg_2_pressed() -> void:
	if Global.money >= Global.upg2cost:
		Global.marketing_lvl += 1
		Global.money -= Global.upg2cost
		Global.upg2cost *= 2
		$Panel/ScrollContainer/VBoxContainer/upg2/upg2cost.text = "$"+str(Global.upg2cost)
		Global.save_data()


func _on_upg_3_pressed() -> void:
	if Global.money >= Global.upg3cost:
		Global.tomato_boost += 0.5
		Global.money -= Global.upg3cost
		$Panel/ScrollContainer/VBoxContainer/upg3.disabled = true
		Global.save_data()
