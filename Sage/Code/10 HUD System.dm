obj
	HUD
		layer=100
		hotslot
			icon='skillcards.dmi'
			New()
				..()
			//	alpha=200
		bars
			icon='Bars.dmi'
			layer=100
			var
				obj/overlay_obj
				obj/text_obj
				pixel_offset
				direction=-1
				matrix/default_transform=matrix()
			proc
				update_bar(var/A,var/B="")
					refresh(A)
					refresh_text(B)
				refresh_text(var/X="")
					overlays-=text_obj
					text_obj.maptext="<font color=white><font size=1>[X]"
					overlays+=text_obj
				refresh(var/X)
					overlays=null
					resize(X)
					offset(X)
					rescreen()
				offset(var/X)
					overlay_obj.pixel_x=(100-X)*direction*1.10*0.5
				resize(var/X)
					var/XX=(X/100)
					overlay_obj.transform=default_transform
					var/matrix/M=matrix()
					M.Scale(XX,1)
					overlay_obj.transform=M
				rescreen()
					var/image/I=image(overlay_obj.icon)
					I.icon_state=overlay_obj.icon_state
					I.transform=overlay_obj.transform
					I.pixel_x=overlay_obj.pixel_x
					I.tag="thingy"
					for(var/image/II in overlays)
						overlays-=II
					overlays+=I
			New()
				..()
				owner=usr
				default_transform=src.transform
				if(name=="bars")
					var/image/I=image('Bars.dmi')
					I.icon_state="bg"
					I.layer=98
					src.underlays+=I
			//	if(layer==99)alpha=150
			health
				layer=99
				direction=1
				icon='healthbar.dmi'
				icon_state="health"
				New()
					..()
			healthbar
				New()
					..()
					icon=null
					text_obj=new/obj()
					text_obj.layer=src.layer
					text_obj.maptext_width=110
					overlays+=text_obj
					overlay_obj=new/obj/HUD/bars/health()
				//	overlays+=overlay_obj
					update_bar(90,"HP:90/100")
			energy
				icon='energybar.dmi'
				icon_state="energy"
				layer=99
				New()
					..()
			energybar
				New()
					..()
					icon=null
					text_obj=new/obj()
					text_obj.layer=src.layer
					text_obj.maptext_width=110
					overlays+=text_obj
					overlay_obj=new/obj/HUD/bars/energy()
				//	overlays+=overlay_obj
					update_bar(40,"EP:40/100")
		location
			icon='Location.dmi'
			New()
				..()
				var/obj/I=new/obj()
				I.layer=101
				I.icon='Icons.dmi'
				I.icon_state="caution"
				I.pixel_y=4
				I.screen_loc="NORTH,WEST"
				icon_obj=I
				src.overlays+=I
				var/obj/O=new /obj()
				O.layer=101
				O.screen_loc="NORTH,WEST"
			//	O.icon=src.icon
				O.maptext_width=320
				O.maptext_height=120
				O.pixel_y=0
				O.pixel_x=30
				src.text_obj=O
				src.overlays+=O
				screen_loc="NORTH,WEST"
				alpha=180
			var
				obj/text_obj
				obj/icon_obj
mob
	var
		obj/HUD/location/location_obj
		obj
			h1
			h2
			h3
			h4
			h5
			hq
			hw
			he
			HUD/bars/healthbar
			HUD/bars/energybar
			bars
	proc
		create_HUD()
			create_location()
			create_hotslots()
			create_bars()
			refresh_location()
		create_bars()
			bars=new/obj/HUD/bars()
			bars.screen_loc="7:16,1:32"
			client.screen+=bars
			healthbar=new/obj/HUD/bars/healthbar()
			healthbar.screen_loc="7:16,2:1"
			client.screen+=healthbar
			energybar=new/obj/HUD/bars/energybar()
			energybar.screen_loc="12,2:1"
			client.screen+=energybar
		refresh_bars()
			healthbar.update_bar(((health/max_health)*100),"<right>HP:[health]/[max_health]")
			energybar.update_bar(((chi/max_chi)*100),"EP:[chi]/[max_chi]")
		create_hottext(var/obj/A,var/B)
			var/obj/O=new/obj()
			O.layer=A.layer
			O.maptext="<font color=white><font size=1>[B]"
			O.pixel_x=3
			O.pixel_y=16
			A.overlays+=O
		create_hotslots()
			var/X=7
			var/XX=16
			h1=new/obj/HUD/hotslot()
			h1.name="H1"
			h1.screen_loc="[X]:[XX],1"
			create_hottext(h1,"1")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=h1
			h2=new/obj/HUD/hotslot()
			h2.name="H2"
			h2.screen_loc="[X]:[XX],1"
			create_hottext(h2,"2")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=h2
			h3=new/obj/HUD/hotslot()
			h3.name="H3"
			h3.screen_loc="[X]:[XX],1"
			create_hottext(h3,"3")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=h3
			h4=new/obj/HUD/hotslot()
			h4.name="H4"
			h4.screen_loc="[X]:[XX],1"
			create_hottext(h4,"4")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=h4
			h5=new/obj/HUD/hotslot()
			h5.name="H5"
			h5.screen_loc="[X]:[XX],1"
			create_hottext(h5,"5")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=h5
			hq=new/obj/HUD/hotslot()
			hq.name="HQ"
			hq.screen_loc="[X]:[XX],1"
			create_hottext(hq,"Q")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=hq
			hw=new/obj/HUD/hotslot()
			hw.name="HW"
			hw.screen_loc="[X]:[XX],1"
			create_hottext(hw,"W")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=hw
			he=new/obj/HUD/hotslot()
			he.name="HE"
			he.screen_loc="[X]:[XX],1"
			create_hottext(he,"E")
		//	XX+=32
		//	if(XX>46)
		//		XX-=46
		//		X+=1
			X+=1
			client.screen+=he
		create_location()
			var/obj/O=new/obj/HUD/location()
			location_obj=O
			client.screen+=O
		refresh_location()
			var/location_name=get_location_name()
			var/location_subname=get_location_subname()
			var/location_icon=get_location_icon()
			client.screen-=location_obj
			usr.location_obj.overlays-=usr.location_obj.text_obj
			usr.location_obj.overlays-=usr.location_obj.icon_obj
			usr.location_obj.text_obj.maptext="<font color=black><font size=3><b>[location_name]</b><br><font size=1> [location_subname]"
			usr.location_obj.icon_obj.icon_state="[location_icon]"
			if(location_icon=="checkmark")
				usr.combat_zone=0
			else
				usr.combat_zone=1
			usr.location_obj.overlays+=usr.location_obj.text_obj
			usr.location_obj.overlays+=usr.location_obj.icon_obj
			client.screen+=location_obj
		get_location_name()
			switch(src.z)
				if(1)return "Other World"
				if(2)return "Yamana"
				if(3)return "Tsuga"
				if(7)return "Western Mountains"
		get_location_subname()
			switch(src.z)
				if(1)return "Spiritual Realm"
				if(2)return "Commercial District"
				if(3)return "Housing District"
				if(7)return "Rural District"
		get_location_icon()
			switch(src.z)
				if(1)return "checkmark"
				if(3)return "checkmark"
			return "caution"