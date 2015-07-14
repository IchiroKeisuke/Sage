obj
	interactable
		proc
			interact()
		log
			icon='Items.dmi'
			icon_state="planks"
		//	pixel_x=-80
			interact()
				if(usr.interact=="wood")
					usr.kill_quickwindow()
					usr.interact=""
					usr.chop(src)
				else
					usr.quickwindow()
					usr.quickwindow_wood()
					usr.interact="wood"
					var/A=usr.loc
					while(usr.loc==A)
						sleep(5)
					usr.interact=""
					usr.kill_quickwindow()
		minerals
			icon='Minerals.dmi'
			density=1
			stone
				icon_state="stone"
				interact()
					if(usr.interact=="stone")
						usr.kill_quickwindow()
						usr.interact=""
						usr.mine_stone(src)
					else
						usr.quickwindow()
						usr.quickwindow_stone()
						usr.interact="stone"
						var/A=usr.loc
						while(usr.loc==A)
							sleep(5)
						usr.interact=""
						usr.kill_quickwindow()
			ore
				icon_state="ore"
				interact()
					if(usr.interact=="stone")
						usr.kill_quickwindow()
						usr.interact=""
						usr.mine_ore(src)
					else
						usr.quickwindow()
						usr.quickwindow_ore()
						usr.interact="stone"
						var/A=usr.loc
						while(usr.loc==A)
							sleep(5)
						usr.interact=""
						usr.kill_quickwindow()
			clay
				icon='landscape.dmi'
				icon_state="clay"
				interact()
					if(usr.interact=="clay")
						usr.kill_quickwindow()
						usr.interact=""
						usr.mine_clay(src)
					else
						usr.quickwindow()
						usr.quickwindow_clay()
						usr.interact="clay"
						var/A=usr.loc
						while(usr.loc==A)
							sleep(5)
						usr.interact=""
						usr.kill_quickwindow()
mob
	var
		collecting=0
	proc
		chop(var/obj/interactable/log/L)
			var/X=5
			if(collecting)return
			else
				collecting=1
				spawn(20)collecting=0
			display_progressbar(20)
			can_move-=1
			while(X>0)
				src.play_sound(pick('WoodA.wav','WoodB.wav','WoodC.wav','WoodD.wav'))
				sleep(4)
				X--
			usr << "You chopped the log up into smaller pieces."
			new/obj/inventory/items/small_wood(L.loc)
			del L
			can_move+=1
		mine_stone(var/obj/interactable/minerals/stone/S)
			var/X=5
			if(collecting)return
			else
				collecting=1
				spawn(20)collecting=0
			display_progressbar(20)
			can_move-=1
			while(X>0)
				flick("punch",src)
				src.play_sound(pick('PickaxeA.wav','PickaxeB.wav','PickaxeC.wav','PickaxeD.wav','PickaxeE.wav'))
				sleep(4)
				X--
			usr << "You broke up some of the stone into haulable pieces"
			usr.stone+=5
			usr.refresh_resources()
			can_move+=1
		mine_ore(var/obj/interactable/minerals/ore/S)
			var/X=5
			if(collecting)return
			else
				collecting=1
				spawn(20)collecting=0
			display_progressbar(20)
			can_move-=1
			while(X>0)
				flick("punch",src)
				src.play_sound(pick('PickaxeA.wav','PickaxeB.wav','PickaxeC.wav','PickaxeD.wav','PickaxeE.wav'))
				sleep(4)
				X--
			usr << "You broke up some of the ore into haulable pieces"
			usr.ore+=5
			usr.refresh_resources()
			can_move+=1
		mine_clay(var/obj/interactable/minerals/clay/S)
			var/X=5
			if(collecting)return
			else
				collecting=1
				spawn(20)collecting=0
			display_progressbar(20)
			can_move-=1
			while(X>0)
				flick("punch",src)
				src.play_sound(pick('PickaxeA.wav','PickaxeB.wav','PickaxeC.wav','PickaxeD.wav','PickaxeE.wav'))
				sleep(4)
				X--
			usr << "You gathered some clay."
			usr.clay+=5
			usr.refresh_resources()
			can_move+=1