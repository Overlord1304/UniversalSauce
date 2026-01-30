extends Node
var money = 6700000000000.0
var tomatoes = 1000
var pepper = 0
var pepper_per_sec = 670000
var pepper_cap = 1000
var revenue_per_sec = 0.0
var revenue_enabled = false
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
var machine_cooldown = 1.0
var spice = 0
var upg1cost = 6.00
var upg2cost = 100.00
var upg3cost = 250.00
var upg3bought = false
var upg4cost = 250.00
var upg4bought = false
var upg5cost = 850.00
var upg5bought = false
var upg6cost = 600.00
var upg6bought = false
var plug1bought = false
var plug2bought = false
var plug3bought = false
var plug4bought = false
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
		"upg3bought": upg3bought,
		"upg4cost": upg4cost,
		"upg4bought": upg4bought,
		"upg5cost": upg5cost,
		"upg5bought": upg5bought,
		"upg6cost": upg6cost,
		"upg6bought": upg6bought,
		"marketing_lvl": marketing_lvl,
		"marketing_boost": marketing_boost,
		"tomato_boost": tomato_boost,
		"machine_cooldown": machine_cooldown,
		"pepper": pepper,
		"pepper_cap": pepper_cap,
		"pepper_per_sec": pepper_per_sec,
		"revenue_enabled": revenue_enabled,
		"plug1bought": plug1bought,
		"plug2bought": plug2bought,
		"plug3bought": plug3bought,
		"plug4bought": plug4bought,
		"spice": spice
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
			upg3bought = data.get("upg3bought",false)
			upg4cost = data.get("upg4cost",250.00)
			upg4bought = data.get("upg4bought",false)
			upg5cost = data.get("upg5cost",850.00)
			upg5bought = data.get("upg5bought",false)
			upg5cost = data.get("upg5cost",600.00)
			upg5bought = data.get("upg5bought",false)
			marketing_lvl = data.get("marketing_lvl",0)
			marketing_boost = data.get("marketing_boost",0)
			tomato_boost = data.get("tomato_boost",0)
			machine_cooldown = data.get("machine_cooldown",0)
			pepper = data.get("pepper",0)
			pepper_per_sec = data.get("pepper_per_sec",5)
			pepper_cap = data.get("pepper_cap",1000)
			revenue_enabled = data.get("revenue_enabled",false)
			plug1bought = data.get("plug1bought",false)
			plug2bought = data.get("plug2bought",false)
			plug3bought = data.get("plug3bought",false)
			plug4bought = data.get("plug4bought",false)
			spice = data.get("spice",0)
	else:
		save_data()
func format_number(n):
	var suffs = ["","K","M","B","T"]
	var index = 0
	while n >= 1000.0 and index < suffs.size() - 1:
		n /= 1000.0
		index+= 1
	n = snapped(n,0.01)
	var text = str(n)
	if "." in text:
		text = text.rstrip("0").rstrip(".")
	return text + suffs[index]
