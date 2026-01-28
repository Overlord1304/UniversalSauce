extends Node
var money = 0.0
var tomatoes = 1000
var sauce_inventory = 0
var lifetime_sauce = 0
var sauce_price = 0.25
var public_demand = 1.0
var tomato_price = 20
var sell_timer = 0.0
var sell_interval = 1.0
var sauce_per_click = 1
var sauce_per_second = 0
var marketing_lvl = 0
var marketing_boost = 0
var tomato_boost = 0
var upg1cost = 6.00
var upg2cost = 100.00
var upg3cost = 250.00
var saves = "user://userdata.save"
func save_data():
	var data = {
		"money": money,
		"tomatoes": tomatoes,
		"sauce_inventory": sauce_inventory,
		"lifetime_sauce": lifetime_sauce,
		"sauce_price": sauce_price,
		"public_demand": public_demand,
		"tomato_price": tomato_price,
		"sauce_per_click": sauce_per_click,
		"sauce_per_second": sauce_per_second,
		"upg1cost": upg1cost,
		"upg2cost": upg2cost,
		"upg3cost": upg3cost,
		"marketing_lvl": marketing_lvl,
		"marketing_boost": marketing_boost,
		"tomato_boost": tomato_boost
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
			sauce_price = data.get("sauce_price",0.25)
			public_demand = data.get("public_demand",1.0)
			tomato_price = data.get("tomato_price",20.0)
			sauce_per_click = data.get("sauce_per_click",1)
			sauce_per_second = data.get("sauce_per_click",0)
			upg1cost = data.get("upg1cost",6.00)
			upg2cost = data.get("upg2cost",100.00)
			upg3cost = data.get("upg3cost",250.00)
			marketing_lvl = data.get("marketing_lvl",0)
			marketing_boost = data.get("marketing_boost",0)
			tomato_boost = data.get("tomato_boost",0)
	else:
		save_data()
