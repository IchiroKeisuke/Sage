obj
	GUI
		sheet_line
			icon='SheetLine.dmi'
			icon_state="1"
			var
				obj/text_obj
			New()
				..()
				var/obj/O=new/obj()
				text_obj=O
				text_obj.maptext_width=190
				text_obj.maptext_height=20
				text_obj.pixel_x=5
				text_obj.pixel_y=2
				overlays+=text_obj
			proc
				change_text(var/A="")
					if(text_obj)
						overlays-=text_obj
						text_obj.maptext="[A]"
						overlays+=text_obj

mob
	var
		obj/GUI/sheet_line
			sheet_name
			sheet_class
			sheet_level
			sheet_clan
			sheet_health
			sheet_chi
			sheet_exp
			sheet_attributes
			sheet_str
			sheet_end
			sheet_agi
			sheet_int
			sheet_wil
	proc
		refresh_charactersheet()
			sheet_name.change_text("<b>[src.name]</b>")
			sheet_class.change_text("<font color=#909090><b>Class</b> : [src.class]")
			sheet_level.change_text("<font color=#909090><b>Level </b> : [src.level]")
			sheet_clan.change_text("<font color=#909090><b>Clan</b> : [src.clan]")
			sheet_health.change_text("<font color=#909090><b>Health</b> : [src.health]/[src.max_health]")
			sheet_chi.change_text("<font color=#909090><b>Chi</b> : [src.chi]/[src.max_chi]")
			sheet_exp.change_text("<font color=#909090><b>Exp</b> : [src.exp]/[src.max_exp]")
			sheet_attributes.change_text("<b>Character Attributes</b>")
			sheet_str.change_text("<font color=#909090><b>Strength</b> : [src.str]")
			sheet_end.change_text("<font color=#909090><b>Endurance</b> : [src.end]")
			sheet_agi.change_text("<font color=#909090><b>Agility</b> : [src.agi]")
			sheet_int.change_text("<font color=#909090><b>Intelligence</b> : [src.int]")
			sheet_wil.change_text("<font color=#909090><b>Willpower</b> : [src.wil]")
		assign_charactersheet(var/A,var/B)
			switch(B)
				if(13)
					sheet_name=A
				if(12)
					sheet_class=A
				if(11)
					sheet_level=A
				if(10)
					sheet_clan=A
				if(9)
					sheet_health=A
				if(8)
					sheet_chi=A
				if(7)
					sheet_exp=A
				if(6)
					sheet_attributes=A
				if(5)
					sheet_str=A
				if(4)
					sheet_end=A
				if(3)
					sheet_agi=A
				if(2)
					sheet_int=A
				if(1)
					sheet_wil=A

		create_charactersheet()
			for(var/X=1 to 13)
				var/obj/GUI/sheet_line/O=new /obj/GUI/sheet_line
		//		var/x=15//X*32+11
		//		var/y=X*21-21+(46-21)
		//		var/sx=1
		//		var/sy=1
				if(X==13||X==6)O.icon_state="3"
				else if(X>6)O.icon_state="1"
				else O.icon_state="2"
		//		while(x>=32)
		//			x-=32
		//			sx++
		//		while(y>=32)
		//			y-=32
		//			sy++
				var/A=X*24
				var/B=0
				while(A>=32)
					A-=32
					B+=1
				O.screen_loc="Char:1:10,[B]:[A-14]"
				O.change_text("Stuff")
				assign_charactersheet(O,X)
				src.client.screen+=O
				X++
			refresh_charactersheet()


	/*		var/space=inventory_space
			for(var/Y=0 to 4)
				for(var/X=1 to 5)
					var/obj/inventory/grid_space/O=new /obj/inventory/grid_space
					var/x=X*32+11
					var/y=Y*-32+11
					var/sx=1
					var/sy=5
					while(x>=46)
						x-=46
						sx++
					while(y>=46)
						y-=46
						sy--
					O.screen_loc="Inv:[sx]:[x-32],[sy]:[y-32]"
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
				*/