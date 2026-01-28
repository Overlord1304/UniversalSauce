extends Control

var money = 0.0
var tomatoes = 10
var sauce_inventory = 0
var lifetime_sauce = 0
var sauce_price = 1.0
var public_demand = 1.0
var tomato_price = 0.5
var sell_timer = 0.0
var sell_interval = 1.0
var saves = "user://userdata.save"
@onready var money_label = $VBoxContainer/Money
@onready var tomato_label = $VBoxContainer/Tomatoes
@onready var sauce_inv_label = $VBoxContainer/SauceInventory
@onready var lifetime_sauce_label = $VBoxContainer/LifetimeSauce
@onready var price_label = $VBoxContainer/Price
@onready var demand_label = $VBoxContainer/Demand
func _ready():
	update_ui()
	load_data()
func save_data():
	var data = {
		"money": money,
		"tomatoes": tomatoes,
		"sauce_inventory": sauce_inventory,
		"lifetime_sauce": lifetime_sauce,
		"sauce_price": sauce_price,
		"public_demand": public_demand,
		"tomato_price": tomato_price
	}
	var file = FileAccess.open(saves,FileAccess.WRITE)
	file.store_var(data)
	file.close()
func load_data():
	if FileAccess.file_exists(saves):
		var file = FileAccess.open(saves,FileAccess.READ)
		var data = file.get_var()
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			money = data.get("money",0.0)
			tomatoes = data.get("tomatoes",0.0)
			sauce_inventory = data.get("sauce_inventory",0.0)
			lifetime_sauce = data.get("lifetime_sauce",0.0)
			sauce_price = data.get("sauce_price",1.0)
			public_demand = data.get("public_demand",1.0)
			tomato_price = data.get("tomato_price",0.5)
	else:
		save_data()
func _process(delta):
	sell_timer += delta
	if sell_timer >= sell_interval:
		sell_timer = 0
		sell_sauce()
	update_ui()
func update_ui():
	money_label.text = "Money: $"+str(money)
	tomato_label.text = "Tomatoes: "+str(tomatoes)
	sauce_inv_label.text= "Sauce Bottles: "+str(sauce_inventory)
	lifetime_sauce_label.text = "Lifetime Sauce Ever Made: "+str(lifetime_sauce)
	price_label.text = "Price Per Bottle: $"+str(sauce_price)
	demand_label.text = "Public Demand: " + str(int(public_demand*100))+"%"
	


func _on_make_sauce_pressed() -> void:
	if tomatoes >= 1:
		tomatoes -= 1
		sauce_inventory += 1
		lifetime_sauce += 1
		update_ui()
		save_data()



func _on_price_inc_pressed() -> void:
	sauce_price += 0.1
	recalc_demand()
	update_ui()
	save_data()

func sell_sauce():
	if sauce_inventory <= 0:
		return
	for i in range(sauce_inventory):
		var sell_chance = public_demand * 0.3
		if randf() < sell_chance:
			sauce_inventory -= 1
			money += sauce_price
	save_data()
func _on_price_dec_pressed() -> void:
	sauce_price -= 0.1 
	recalc_demand()
	update_ui()
	save_data()
func recalc_demand(): 
	public_demand = clamp(1.5-sauce_price*0.3,0.05,2.0)
func _on_buy_tomato_pressed() -> void:
	if money >= tomato_price:
		money -= tomato_price
		tomatoes += 1
		update_ui()
		save_data()
