extends Control
func _ready():
	$Panel/ScrollContainer/VBoxContainer/upg1/upg1cost.text = "$"+Global.format_number(Global.upg1cost)
	$Panel/ScrollContainer/VBoxContainer/upg2/upg2cost.text = "$"+Global.format_number(Global.upg2cost)
	$Panel/ScrollContainer/VBoxContainer/upg3/upg3cost.text = "$"+Global.format_number(Global.upg3cost)
	$Panel/ScrollContainer/VBoxContainer/upg4/upg4cost.text = "$"+Global.format_number(Global.upg4cost)
	$Panel/ScrollContainer/VBoxContainer/upg5/upg5cost.text = "$"+Global.format_number(Global.upg5cost)
	$Panel/ScrollContainer/VBoxContainer/upg6/upg6cost.text = "$"+Global.format_number(Global.upg6cost)
	if Global.upg3bought:
		$Panel/ScrollContainer/VBoxContainer/upg3.disabled = true
	if Global.upg4bought:
		$Panel/ScrollContainer/VBoxContainer/upg4.disabled = true
	if Global.upg5bought:
		$Panel/ScrollContainer/VBoxContainer/upg5.disabled = true
	if Global.upg6bought:
		$Panel/ScrollContainer/VBoxContainer/upg6.disabled = true
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
	if Global.money >= Global.upg3cost and !Global.upg3bought:
		Global.tomato_boost += 0.5
		Global.money -= Global.upg3cost
		Global.upg3bought = true
		$Panel/ScrollContainer/VBoxContainer/upg3.disabled = true
		Global.save_data()


func _on_upg_4_pressed() -> void:
	if Global.money >= Global.upg4cost and !Global.upg4bought:
		Global.machine_cooldown /= 1.25
		Global.upg4bought = true
		Global.money -= Global.upg4cost
		$Panel/ScrollContainer/VBoxContainer/upg4.disabled = true
		Global.save_data()


func _on_upg_5_pressed() -> void:
	if Global.money >= Global.upg5cost and !Global.upg5bought:
		Global.machine_cooldown /= 1.5
		Global.upg5bought = true
		Global.money -= Global.upg5cost
		$Panel/ScrollContainer/VBoxContainer/upg5.disabled = true
		Global.save_data()


func _on_upg_6_pressed() -> void:
	if Global.money >= Global.upg6cost and !Global.upg6bought:
		Global.tomato_boost += 0.75
		Global.pepper += 5000
		Global.upg6bought = true
		Global.money -= Global.upg6cost
		$Panel/ScrollContainer/VBoxContainer/upg6.disabled = true
		Global.save_data()
