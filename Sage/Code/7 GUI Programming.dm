











obj
	GUI
		label
			icon='BlackIcon.dmi'
			icon_state="nothing"
			layer=91
			var
				string="Label"
				format="<font color=white>"
				box_width=128
				box_height=32
			New()
				..()
				var/obj/O=new/obj()
				O.layer=src.layer+1
				O.maptext_width=box_width
				O.maptext_height=box_height
				O.maptext="[format][string]"
				src.overlays+=O
			class_select
				string="<font size=4><font color=black><b>Class Selection"
				box_width=256
				box_height=165
			character_cust
				string="<font size=3><b>Character Customization"
				box_width=256
				box_height=165
			character_desc
				string="This the character customization screen, you can select what type of look you want your character to have."
				box_width=256
				box_height=160
			skin_tone
				string="Skin Tone"
			hair_color
				string="Hair Color"
			clothing_color
				string="Clothing Colors"
		quickwindow
			icon='QuickWindow.dmi'
			var/obj/text_obj
			var/obj/header_obj
			layer=90
			proc
				change_text(var/A="")
					overlays-=text_obj
					text_obj.maptext="<font color=#959595>[A]"
					overlays+=text_obj
				change_header(var/A="<font color=#979797>")
					overlays-=header_obj
					header_obj.maptext=A
					overlays+=header_obj
			New()
				..()
				text_obj=new/obj()
				text_obj.layer=src.layer
				text_obj.pixel_x=4
				text_obj.pixel_y=4
				text_obj.maptext_width=140
				text_obj.maptext_height=60
				overlays+=text_obj
				header_obj=new/obj()
				header_obj.pixel_x=4
				header_obj.pixel_y=70
				header_obj.maptext_width=96
				header_obj.layer=src.layer
				overlays+=header_obj
		progressbar
			icon='ProgressBar.dmi'
		//	icon_state="0"
			layer=90
			var/matrix/default_transform
			var/obj/overlay_obj
			proc
				change_percent(var/A)
					A=round(A,10)
					A=A/10
					overlay_obj.icon_state="[A]"
				resize(var/X)
				//	var/XX=(X/100)
				//	overlay_obj.transform=default_transform
					overlay_obj.transform=default_transform
					var/matrix/M=matrix()
					M.Scale((X/100),1)
					overlay_obj.transform=M
				offset(var/X)
					overlay_obj.pixel_x=(100-X)*1*0.5*-1
				flow(var/A)
					var/X=0
					while(X<100)
						X+=(100/A)
						overlays-=overlay_obj
						src.resize(X)
						src.offset(X)
						overlays+=overlay_obj
						sleep(1)
					del src
			New(var/A,var/mob/B)
				..()
				owner=B
				var/obj/O=new/obj()
				overlay_obj=O
				src.screen_loc="CENTER:-32,CENTER+2"
				O.icon=src.icon
				O.icon_state="0"
				O.layer=90
				src.default_transform=overlay_obj.transform
				src.overlays+=O
				spawn(0)flow(A)
mob
	proc
		display_progressbar(var/A)
			var/obj/GUI/progressbar/P=new/obj/GUI/progressbar(A,src)
			usr.client.screen+=P
		quickwindow()
			var/obj/O=new/obj/GUI/quickwindow()
			O.screen_loc="CENTER-1,CENTER+3"
			client.screen+=O
		quickwindow_wood()
			for(var/obj/GUI/quickwindow/W in client.screen)
				W.change_text("Chop logs into Wood?\n \n \[Space to confirm\]")
				W.change_header("Logs")
		quickwindow_stone()
			for(var/obj/GUI/quickwindow/W in client.screen)
				W.change_text("Break up Stone?\n\n \[Space to confirm\]")
				W.change_header("Stone")
		quickwindow_ore()
			for(var/obj/GUI/quickwindow/W in client.screen)
				W.change_text("Break up Ore?\n\n \[Space to confirm\]")
				W.change_header("Ore")
		quickwindow_clay()
			for(var/obj/GUI/quickwindow/W in client.screen)
				W.change_text("Gather Clay?\n\n \[Space to confirm\]")
				W.change_header("Clay")
		quickwindow_build(var/A)
			for(var/obj/GUI/quickwindow/W in client.screen)
				W.change_text("Construct [A]?\n\n \[Space to confirm\]")
				W.change_header("Construction")
		kill_quickwindow()
			for(var/obj/GUI/quickwindow/W in client.screen)
				del W