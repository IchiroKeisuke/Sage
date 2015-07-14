obj
	hair
		layer=4
		short_hair
			icon='ShortHair.dmi'

mob
	var
		icon
			hair='ShortHair.dmi'
		hair_color=rgb(1,1,1,200)
		skin_tone=1

mob/proc/update_inventory()
	var/count=0
	for(var/obj/inventory/H in contents)
		src << output(H, "inventory.grid1:[++count]")
	winset(src, "inventory.grid1", "cells=\"[count]\"")
mob
	proc
		starter_clothes()
			var/obj/inventory/items/equippable/A=new/obj/inventory/items/equippable/shirt()
			var/obj/inventory/items/equippable/B=new/obj/inventory/items/equippable/pants()
			var/obj/inventory/items/equippable/C=new/obj/inventory/items/equippable/sword()
			A.equip=1
			B.equip=1
			usr.contents+=A
			usr.contents+=B
			usr.contents+=C
			usr.refresh_inventory()
			usr.redraw_character()
		redraw_character()
			usr.overlays=null
			switch(usr.skin_tone)
				if(1)usr.icon='Base.dmi'
				if(2)usr.icon='Base2.dmi'
			for(var/obj/inventory/items/equippable/E in usr.contents)
				if(E.equip==1)
					var/image/I=image(E.icon)
					I.icon+=E.dye_color
					usr.overlays+=I
			usr.set_name(usr.name)
			if(usr.hair!=null&&usr.hair_color!=null)
				var/image/I=image(usr.hair)
				I.icon+=usr.hair_color
				usr.overlays+=I
		//	var/obj/B=new usr.hair
		//	usr.overlays+=B
obj
	inventory
		items
			layer=20
			var
				item_ID=0
		//	icon='Items.dmi'
			proc
				double_click()
			collectables
				var/obj/collectable_spawner/spawner_ref
				var/obj/inventory/items/collected/collected_obj
				herbs
					icon='Herbs.dmi'
					lemon_grass
						icon_state="lemon grass"
						collected_obj=/obj/inventory/items/collected/herbs/lemon_grass
						name="Lemon Grass"
						desc="A herb with medicinal properties. It is often found in tropical areas."
				pickup()
					if(spawner_ref)
						spawn(0)
							spawner_ref.respawn_obj()
						spawn(0.5)
							spawner_ref=null
							new collected_obj(usr)
							usr.refresh_inventory()
							del src
			collected
				herbs
					icon='Herbs.dmi'
					lemon_grass
						icon_state="collected lemon grass"
						name="Lemon Grass"
						desc="A herb with medicinal properties. It is often found in tropical areas."


			pork
				icon='Items.dmi'
				icon_state="pork"
				layer=40
				name="Pork"
				desc="Raw meat that is taken from pigs(boars)"
			small_wood
				icon='Items.dmi'
				icon_state="small wood"
				layer=40
				Click()
					usr.wood+=10
					usr.refresh_resources()
					usr << 'DropA.wav'
					del src
			placeable
				var/obj/inventory/items/placed/place_obj
				furniture
					icon='furniture.dmi'
					chair
						icon_state="Chair"
						place_obj=/obj/inventory/items/placed/furniture/chair
						place()
							for(var/area/construction/C in range(0,usr))
								src.loc=null
								spawn(0)usr.refresh_inventory()
								var/obj/A=new place_obj(usr.loc)
								A.dir=usr.dir
								A.owner=usr.key
								spawn(10)del src
					table
						place_obj=/obj/inventory/items/placed/furniture/table
						icon_state="Table"
					cupboard
						place_obj=/obj/inventory/items/placed/furniture/cupboard
						icon_state="Cupboard"
					containers
						place_obj=/obj/inventory/items/placed/furniture/containers
						icon_state="Containers"
				drop()
					place()
				proc
					place()
						for(var/area/construction/C in range(0,usr))
							src.loc=null
							spawn(0)usr.refresh_inventory()
							var/obj/A=new place_obj(usr.loc)
							A.owner=usr.key
							spawn(10)del src
			placed
				var/obj/inventory/items/placeable/reclaim_obj
				furniture
					icon='furniture.dmi'
					chair
						icon_state="Chair"
						reclaim_obj=/obj/inventory/items/placeable/furniture/chair
					table
						icon_state="Table"
						reclaim_obj=/obj/inventory/items/placeable/furniture/table
						density=1
					cupboard
						icon_state="Cupboard"
						reclaim_obj=/obj/inventory/items/placeable/furniture/cupboard
						density=1
					containers
						icon_state="Containers"
						reclaim_obj=/obj/inventory/items/placeable/furniture/containers
						density=1
				pickup()
					if(usr.key==src.owner)
						reclaim()
					else
						return
				proc
					reclaim()
						src.loc=null
						spawn(0)usr.refresh_inventory()
						var/obj/A=new reclaim_obj(usr)
						A.owner=usr
						spawn(10)del src
			Click()
				..()
				pickup()
			proc
				pickup()
					set category=null
					set src in range(1)
					src.loc=usr
					usr.refresh_inventory()
					usr << 'DropA.wav'
				drop()
					set category=null
					set src in usr
					item_ID=0
					src.loc=usr.loc
					usr.refresh_inventory()
					usr << 'DropB.wav'
			scrolls
				verb
					examine()
						set category=null

			equippable
				var
					equip=0
					dye_color=rgb(1,1,1,220)
				proc
					set_color(var/c as color)
						dye_color=c
				layer=20
				double_click()
					equip()
				drop()
					if(equip==1)
						usr << "You need to unequip [src] before dropping it."
						return
					..()
				verb
					equip()
						set category=null
						if(equip==0)
							equip=1
						else
							equip=0
			//				usr << 'Unequip.wav'
						usr.redraw_character()
				sword
					name="Short Sword"
					desc="Slightly shorter and lighter than the average sword. Atk+"
					icon='Sword.dmi'
					equip()
						set category=null
						if(equip==0)
							equip=1
							usr<<'sword-unsheathe.wav'
							usr.str_buff+=0.05
						else
							equip=0
							usr.str_buff-=0.05
			//				usr << 'Unequip.wav'
						usr.redraw_character()
				shirt
					name="Cloth Shirt"
					desc="A simple cloth shirt."
					icon='Shirt.dmi'
				pants
					name="Cloth Pants"
					desc="A pair of simple cloth pants."
					icon='Pants.dmi'
			consumeable
				var
					consume_message=""
				double_click()
					consume()
				verb
					consume()
						set category=null
						usr << 'Eat.wav'
				ricebowl
					icon_state="ricebowl"
					name="Ricebowl"
					consume()
						usr << "<font color=teal>You consume the rice! (+10%Nutrition)"
						src.loc=null
						usr.update_inventory()
						del src
				potions
					icon='Items.dmi'
					var
						consumed=0
					health
						var
							health_boost=10
						consume()
							if(consumed)return
							consumed=1
							usr << consume_message
							spawn(0)new/obj/particle_system/health(usr)
							//src.loc=null
							var/x=10
							while(x>0)
								x--
								if(usr)
									usr.health+=health_boost/x
									usr.refresh_bars()
								sleep(0.5)
						//	spawn(0.5)
							src.loc=null
							usr.refresh_inventory()
							del src
						small
							name="Small Health Potion"
							desc="Restores a small portion of health"
							icon_state="small health"
						medium
							name="Medium Health Potion"
							desc="Restores a moderate portion of health"
							icon_state="medium health"
							health_boost=20
						large
							name="Large Health Potion"
							desc="Restores a sizeable portion of health"
							icon_state="large health"
							health_boost=35
					energy
						var
							energy_boost=10
						consume()
							if(consumed)return
							consumed=1
							usr << consume_message
							spawn(0)new/obj/particle_system/energy(usr)
							var/x=10
							while(x>0)
								x--
								if(usr)
									usr.chi+=energy_boost/x
									usr.refresh_bars()
								sleep(0.5)
							src.loc=null
							usr.refresh_inventory()
							del src
						small
							name="Small Energy Potion"
							desc="Restores a small portion of chi."
							icon_state="small energy"
						medium
							name="Medium Energy Potion"
							desc="Restores a moderate portion of chi"
							icon_state="medium energy"
							energy_boost=20
						large
							name="Large Energy Potion"
							desc="Restores a sizeable portion of chi"
							icon_state="large energy"
							energy_boost=35