mob
	var


		wood=0
		stone=0
		ore=0
		clay=0

		construction_skill=10
		cooking_skill=10
		crafting_skill=10
		fishing_skill=10
		farming_skill=10
		trading_skill=10

	Stat()
		statpanel("Skills")
		if(statpanel("Skills"))
			for(var/obj/skill_cards/S in usr.contents)
				stat(S)
		statpanel("Trades")
		if(statpanel("Trades"))
			stat("<font size=1>Trades can be refined by purchasing and studying books or by performing relevant actions")
			stat("")
			stat("Construction : [construction_skill]")
			stat("HandiCrafts : [crafting_skill]")
			stat("Cooking : [cooking_skill]")
			stat("Fishing : [fishing_skill]")
			stat("Farming : [farming_skill]")
			stat("Trading : [trading_skill]")