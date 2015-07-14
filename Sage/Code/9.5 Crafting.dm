mob
	var
		crafting_ability=0
		list
			crafting_list=list(0.)
			furniture_one=list("Table","Chair","Cupboard","Containers")
			furniture_two=list("Chair")
			furniture_three=list("")
			items_one=list("Small Health Potion","Medium Health Potion", "Large Health Potion","Small Energy Potion","Medium Energy Potion", "Large Energy Potion")

	proc
		get_uncommon_ingredient_type(var/x)
			var/obj/AA
			switch(x)
				if("Lemon Grass")
					AA=new/obj/inventory/items/collected/herbs/lemon_grass()
			return AA.type
		check_uncommon_ingredients()
			//need to find ingredients in list uncommon_ingredients and check if usr has them
			var/list/holder_list=list()
			for(var/A in usr.uncommon_ingredients)
				var/obj/OO=get_uncommon_ingredient_type(A)
				var/x=0
				for(var/obj/inventory/items/I in usr.contents)
					if(I.type==OO)
						x++
						I.loc=null
						holder_list+=I
						break
				if(x==0)
					usr.refresh_inventory()
					usr << "[A] wasnt found in your inventory"
					return FALSE
			for(var/obj/I in holder_list)
				I.loc=usr
			return TRUE
		take_uncommon_ingredients()
			//need to take ingredients found in list uncommon_ingredients
			for(var/A in usr.uncommon_ingredients)
				var/obj/OO=get_uncommon_ingredient_type(A)
				for(var/obj/inventory/items/I in usr.contents)
					if(I.type==OO)
						x++
						del I
						///usr.contents-=I
					//	holder_list+=I
						break
			usr.refresh_inventory()
		open_crafting_panel(var/obj/interactable/construction/utility/crafting_bench/C)
			winshow(src,"Crafting",1)
			winset(src,"Crafting.Quantity","Text=1")
			crafting_loop(C)
		crafting_loop(var/obj/interactable/construction/utility/crafting_bench/C)
			while(get_dist(src,C)<3)
				sleep(5)
			winshow(src,"Crafting",0)
		show_recipes(icon/I,list/L)
			var/count=1
			src<<output(null,"Crafting.Recipes")
			while(count<= L.len)
				var/obj/crafting/recipe/C=get_recipe(L[count])
				src << output(C, "Crafting.Recipes:[count]")
				count++
			winset(src, "Crafting.Recipes", "cells=\"[count]\"")
	/*	show_ingredients(list/L)
			var/count=1
			while(count<= L.len)
				var/obj/crafting/recipe/C=new/obj/crafting/recipe(src)
				C.icon=I
				C.icon_state=L[count]
				C.name=C.icon_state
				C.desc=get_recipe_desc(C.name)
				src << output(C, "Crafting.Recipes:[count]")
				count++
			winset(src, "Crafting.Recipes", "cells=\"[count]\"")*/
		get_recipe(var/A="")
			var/obj/crafting/recipe/AA
			switch(A)
				if("Chair")
					AA=new/obj/crafting/recipe/chair(usr)
				if("Table")
					AA=new/obj/crafting/recipe/table(usr)
				if("Containers")
					AA=new/obj/crafting/recipe/containers(usr)
				if("Cupboard")
					AA=new/obj/crafting/recipe/cupboard(usr)
				if("Small Health Potion")
					AA=new/obj/crafting/recipe/small_health_potion(usr)
				if("Medium Health Potion")
					AA=new/obj/crafting/recipe/medium_health_potion(usr)
				if("Large Health Potion")
					AA=new/obj/crafting/recipe/large_health_potion(usr)
				if("Small Energy Potion")
					AA=new/obj/crafting/recipe/small_energy_potion(usr)
				if("Medium Energy Potion")
					AA=new/obj/crafting/recipe/medium_energy_potion(usr)
				if("Large Energy Potion")
					AA=new/obj/crafting/recipe/large_energy_potion(usr)
			return AA
			return "No Description Available"
	verb
		show_furniture_recipes()
			set category=null
			crafting_list=list()
			crafting_list+=furniture_one
			if(crafting_ability>25)
				crafting_list+=furniture_two
			if(crafting_ability>60)
				crafting_list+=furniture_three
			show_recipes('furniture.dmi',crafting_list)
		show_item_recipes()
			set category=null
			crafting_list=list()
			crafting_list+=items_one
			show_recipes('Items.dmi',crafting_list)
			//fix this later


	verb
		close_crafting()
			set category=null
			winshow(src,"Crafting",0)
		craft()
			set category=null
			if(usr.citem!=null)
				if(usr.cwood>usr.wood||usr.cstone>usr.stone||usr.core>usr.ore||usr.cclay>usr.clay)
					return
				if(usr.check_uncommon_ingredients()!=TRUE)
					return
				else
					usr.wood-=usr.cwood
					usr.stone-=usr.cstone
					usr.core-=usr.ore
					usr.cclay-=usr.clay
					usr.take_uncommon_ingredients()
					var/obj/A=new usr.citem(usr)
					A.owner=usr
			usr.refresh_inventory()

mob
	var
		cwood=0
		cstone=0
		core=0
		cclay=0
		obj/citem
		list/uncommon_ingredients=list()


obj
	crafting
		ingredient
			icon='ingredients.dmi'
			wood
				icon_state="Wood"
			lemon_grass
				name=""
				icon='Herbs.dmi'
				icon_state="lemon grass"
			stone
			ore
				icon_state="Ore"
			clay
		recipe
			var
				obj/citem
				list/ingredients=list()
				wood=0
				stone=0
				ore=0
				clay=0
			desc="Recipe Description Unavailable"
			small_health_potion
				name="Small Health Potion"
				icon='Items.dmi'
				icon_state="small health"
				desc="Restores a small portion of health"
				ore=1
				ingredients=list("Lemon Grass")
				citem=/obj/inventory/items/consumeable/potions/health/small
			medium_health_potion
				name="Medium Health Potion"
				icon='Items.dmi'
				icon_state="medium health"
				desc="Restores a moderate portion of health"
				ore=2
				ingredients=list("Lemon Grass","Lemon Grass")
				citem/obj/inventory/items/consumeable/potions/energy/medium
			large_health_potion
				name="Large Health Potion"
				icon='Items.dmi'
				icon_state="large health"
				desc="Restores a sizeable portion of health"
				ore=3
				ingredients=list("Lemon Grass","Lemon Grass","Lemon Grass")
				citem/obj/inventory/items/consumeable/potions/energy/large
			small_energy_potion
				name="Small Energy Potion"
				icon='Items.dmi'
				icon_state="small energy"
				desc="Restores a small portion of chi(energy)"
				ore=1
				ingredients=list("Lemon Grass")
				citem=/obj/inventory/items/consumeable/potions/energy/small
			medium_energy_potion
				name="Medium Energy Potion"
				icon='Items.dmi'
				icon_state="medium energy"
				desc="Restores a medium portion of chi(energy)"
				ore=2
				ingredients=list("Lemon Grass")
				citem=/obj/inventory/items/consumeable/potions/energy/medium
			large_energy_potion
				name="Large Energy Potion"
				icon='Items.dmi'
				icon_state="large energy"
				desc="Restores a sizeable portion of chi(energy)"
				ore=3
				ingredients=list("Lemon Grass")
				citem=/obj/inventory/items/consumeable/potions/energy/large
			containers
				wood=2
				icon='Furniture.dmi'
				icon_state="Containers"
				desc="A stack of simple containers used in daily life."
				citem=/obj/inventory/items/placeable/furniture/containers
			cupboard
				wood=5
				icon='Furniture.dmi'
				icon_state="Cupboard"
				desc="A decorative cupboard"
				citem=/obj/inventory/items/placeable/furniture/cupboard
			chair
				wood=5
				icon='furniture.dmi'
				icon_state="Chair"
				desc="A simple chair to sit in."
				citem=/obj/inventory/items/placeable/furniture/chair
			table
				wood=5
				icon='furniture.dmi'
				icon_state="Table"
				desc="A simple table."
				citem=/obj/inventory/items/placeable/furniture/table
			desc="Description not available"
			Click()
				usr.citem=src.citem
				usr.cwood=src.wood
				show_recipe(usr)
				usr.uncommon_ingredients=src.ingredients
			proc
				show_recipe(var/mob/M)
					winset(usr,"Crafting.Description","text=\"[src.desc]\"")
					show_ingredients()
					usr << output(src,"Crafting.SelectedRecipe:1")
					winset(usr,"Crafting.SelectedRecipe","cells=\"[1]\"")
				show_ingredients()
					if(usr.client)
						var/A=0
						A+=show_common_ingredients()
						A+=show_uncommon_ingredients(A)
						winset(usr, "Crafting.Ingredients", "cells=\"[A]\"")
				show_common_ingredients()
					var/x=0
					if(src.wood>0)
						x++
						var/obj/crafting/ingredient/wood/CC=new/obj/crafting/ingredient/wood(usr)
						CC.name="[src.wood]"
						usr << output(CC, "Crafting.Ingredients:[x]")
					if(src.ore>0)
						x++
						var/obj/crafting/ingredient/ore/CC=new/obj/crafting/ingredient/ore(usr)
						CC.name="[src.ore]"
						usr << output(CC, "Crafting.Ingredients:[x]")
					return x
				show_uncommon_ingredients(var/A)
					var/x=0
					var/y=ingredients.len
					while(x<y)
						x++
						var/obj/O=get_uncommon_ingredient(ingredients[x])
						var/obj/B=new O(usr)
						usr << output(B,"Crafting.Ingredients:[x+A]")
						new O(usr)
					return x
				get_uncommon_ingredient(var/x)
					var/obj/AA
					switch(x)
						if("Lemon Grass")
							AA=new/obj/crafting/ingredient/lemon_grass()
					return AA.type