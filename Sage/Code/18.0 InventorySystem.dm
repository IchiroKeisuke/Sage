#define DEBUG
mob
	var/obj/item_display
	proc
		refresh_item_display(var/obj/inventory/items/I)
			if(I)
				item_display.icon=I.icon
				item_display.icon_state=I.icon_state
				winset(src,"Inventory.item_name_display","text=\"[I.name]\"")
				winset(src,"Inventory.item_desc_display","text=\"[I.desc]\"")
		refresh_inventory()
			var/list/find_holder=list()
			var/list/find_ID=list()
			for(var/obj/inventory/items/O in contents)
				find_holder+=O
				if(O.item_ID!=0)find_ID+=O
			for(var/obj/inventory/grid_space/G in src.grid_spaces)
				G.filled=0
				G.overlays=null
				G.mouse_drag_pointer=null
				G.grid_ref=null
			used_inventory_space=0
			while(used_inventory_space<inventory_space&&length(find_ID)>0)
				for(var/obj/inventory/items/O in find_holder)
					for(var/obj/inventory/grid_space/G in src.grid_spaces)
						if(G.filled==0&&G.grid_ID==O.item_ID)
							used_inventory_space+=1
							G.filled=1
							G.grid_ref=O
							O.item_ID=G.grid_ID
							G.overlays+=icon(O.icon,O.icon_state)
							G.mouse_drag_pointer=icon(O.icon,O.icon_state)
							find_holder-=O
							find_ID-=O
							break
				sleep(1)
			while(used_inventory_space<inventory_space&&length(find_holder)>0)
				for(var/obj/inventory/items/O in find_holder)
					for(var/obj/inventory/grid_space/G in src.grid_spaces)
						if(G.filled==0)
							used_inventory_space+=1
							G.filled=1
							G.grid_ref=O
							O.item_ID=G.grid_ID
							G.overlays+=icon(O.icon,O.icon_state)
							G.mouse_drag_pointer=icon(O.icon,O.icon_state)
							find_holder-=O
							break
				sleep(1)
		create_inventory()
			var/space=inventory_space
			for(var/Y=0 to 4)
				for(var/X=1 to 5)
					var/obj/inventory/grid_space/O=new /obj/inventory/grid_space
		//			var/x=X*32+11
		//			var/y=Y*-32+11
		//			var/sx=1
		//			var/sy=5
		//			while(x>=46)
//						x-=46
	//					sx++
		//			while(y>=46)
			//			y-=46
				//		sy--
					O.screen_loc="Inv:[X],[5-Y]"
					O.grid_ID=X+Y*5
					if(space>0)
						space-=1
						O.icon_state="unlocked"
					else
						O.icon_state="locked"
					src.client.screen+=O
					grid_spaces+=O
					X++
				Y--
			var/obj/O=new/obj()
			O.screen_loc="item_display:1,1"
			src.item_display=O
			src.client.screen+=src.item_display

	var
		list/grid_spaces=list()
		used_inventory_space=0
		inventory_space=20
		max_inventory_space=25
obj
	inventory
		grid_space
			layer=1
			icon='Inventory.dmi'
			var
				filled=0
				grid_ID=0
				obj/inventory/items/grid_ref
			MouseEntered()
				usr.refresh_item_display(grid_ref)
			MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
				if("default.map1"==over_control)
					if(src.grid_ref)
						if(istype(grid_ref,/obj/inventory/items))
							var/obj/inventory/items/I=grid_ref
							I.drop()
				else if(istype(over_object,/obj)&&src.grid_ref!=null)
					var/obj/AA=over_object
					if("grid space"==AA.name)
						if(istype(AA,/obj/inventory/grid_space))
							var/obj/inventory/grid_space/O=AA
							if(O.grid_ref!=null)
								var/C=src.grid_ref.item_ID
								usr << C
								src.grid_ref.item_ID=O.grid_ref.item_ID
								O.grid_ref.item_ID=C
								usr << C
							else
								src.grid_ref.item_ID=O.grid_ID
							usr.refresh_inventory()

			DblClick()
				if(src.grid_ref)
					if(istype(grid_ref,/obj/inventory/items))
						var/obj/inventory/items/I=grid_ref
						I.double_click()
		items