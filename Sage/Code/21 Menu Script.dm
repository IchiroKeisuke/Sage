mob
	var
		lx=0
		ly=0
		lz=0
		creating=0
mob
	var
		logged=0
turf
	hud
		background
			icon='BG.dmi'
			layer=89
		background2
			icon='BG.dmi'
			icon_state="BG2"
			layer=89
			pixel_y=-64
			pixel_x=-100
			New()
				..()

		character_window
			icon='charactercreationwindow.dmi'
			layer=90
		bg2
			layer=90
			icon='CharacterHolder.dmi'
			proc
				display_info(var/mob/M)
					var/image/I=new/image(null,src)
					var/image/II=new/image(null,src)
					I.tag="bg2"
					II.tag="bg2"
					I.layer=91
					II.layer=91
					II.maptext={"<font color=black><b><font size=1> Name : </b>[M.name]"}
					II.maptext_width=120
					II.pixel_y=90
					II.pixel_x=1
					I.pixel_y=60
					I.pixel_x=1
					I.maptext_width=120
					I.maptext="<font color=black><b><font size=1> Level : </b> [M.level] \n <b>Class : </b> [M.class]]"
					M << I
					M << II
		Sage_title
			icon='win_bg.dmi'
			icon_state="Sage"
			layer=90
		bg
			layer=90
			icon=null
			icon='Title.dmi'
			//pixel_y=-8
			New()
				..()
				//alpha=240
				var/obj/O=new/obj()
				O.layer=91
				O.maptext={"<font color=white><b>Bulletin</b>\n \n <font color=#005599>Alpha 1.0.0 Released! \n\n <font color=yellow>Welcome back to Sage!"}
				O.maptext_width=300
				O.maptext_height=240
				O.pixel_x=8
				O.pixel_y=80
				src.overlays+=O
			/*	var/obj/OO=new/obj()
				OO.layer=90
				OO.maptext={"<font color=black><b>Bulletin</b>\n \n <font color=black>Alpha 1.0.0 Released! \n\n <font color=black>Welcome back to Sage!"}
				OO.maptext_width=300
				OO.maptext_height=240
				OO.pixel_x=7
				OO.pixel_y=90
				src.overlays+=OO
				var/obj/OOO=new/obj()
				OOO.layer=90
				OOO.maptext={"<font color=black><b>Bulletin</b>\n \n <font color=black>Alpha 1.0.0 Released! \n\n <font color=black>Welcome back to Sage!"}
				OOO.maptext_width=300
				OOO.maptext_height=240
				OOO.pixel_x=9
				OOO.pixel_y=90
				src.overlays+=OOO
				var/obj/OOOO=new/obj()
				OOOO.layer=90
				OOOO.maptext={"<font color=black><b>Bulletin</b>\n \n <font color=black>Alpha 1.0.0 Released! \n\n <font color=black>Welcome back to Sage!"}
				OOOO.maptext_width=300
				OOOO.maptext_height=240
				OOOO.pixel_x=8
				OOOO.pixel_y=91
				src.overlays+=OOOO
				var/obj/OOOOO=new/obj()
				OOOOO.layer=90
				OOOOO.maptext={"<font color=black><b>Recent News</b>\n \n <font color=black>Alpha 1.0.0 Released! \n\n <font color=black>Welcome back to Sage!"}
				OOOOO.maptext_width=300
				OOOOO.maptext_height=240
				OOOOO.pixel_x=8
				OOOOO.pixel_y=89
				src.overlays+=OOOOO*/
		selectable_bg
			layer=91
			icon='HUD.dmi'
			New()
				..()
				src.alpha=125
			blackicon
				New()
					..()
					src.alpha=255
				icon='BlackIcon.dmi'
			upper_middle
				icon='HUD2.dmi'
				icon_state=""
			left
				icon_state="left"
			right
				icon_state="right"
			middle
				icon_state="middle"
	selectable
		icon='HUD.dmi'
		icon_state="test"
		layer=99
		pixel_x=0
		var
			text_string=""
		New()
			..()
			var/obj/O=new/obj()
			O.layer=src.layer+1
			O.maptext="<font color=white><b>[text_string]"
			O.maptext_width=96
			O.pixel_x=src.pixel_x
			src.overlays+=O
		var
			order=1
		MouseExited()
			for(var/image/D in usr.client.images)
				if(D.tag=="HUD cursor")del D
		MouseEntered()
			var/image/I=image('HUD.dmi',src)
			I.layer=100
			I.pixel_y=8
			I.tag="HUD cursor"
			usr.client.images+=I
			usr << 'ClickChakra.wav'
		Click()
			..()
			usr << 'MainMenuButton.wav'
		back_to_main_menu
			icon='MiniHUD.dmi'
			icon_state="back"
			Click()
				..()
				usr.icon=null
				usr.overlays=null
				usr.spawn_character()
		character_customize
			icon='MiniHUD.dmi'
			arrow
				icon_state="arrow"
				Click()
					..()
					usr.dir=src.dir
					for(var/turf/selectable/character_customize/platform/P in range(5,src))P.redraw_fake(usr)
			recolor_hair
				icon_state="recolor"
				Click()
					..()
					var/A=input("What color hair?") as color
					usr.hair_color=A
					usr.redraw_character()
					for(var/turf/selectable/character_customize/platform/P in range(10,src))P.redraw_fake(usr)
			recolor_shirt
				icon_state="recolor"
				Click()
					..()
					var/A as color
					A=input("What color would you like to dye your shirt?") as color
					for(var/obj/inventory/items/equippable/shirt/S in usr.contents)
						S.set_color(A)
					usr.redraw_character()
					for(var/turf/selectable/character_customize/platform/P in range(10,src))P.redraw_fake(usr)
			recolor_pants
				icon_state="recolor"
				Click()
					..()
					var/A as color
					A=input("What color would you like to dye your pants?") as color
					for(var/obj/inventory/items/equippable/pants/S in usr.contents)
						S.set_color(A)
					usr.redraw_character()
					for(var/turf/selectable/character_customize/platform/P in range(10,src))P.redraw_fake(usr)
			light_skin
				icon_state="light skin"
				Click()
					..()
					usr.skin_tone=1
					usr.redraw_character()
					for(var/turf/selectable/character_customize/platform/P in range(10,src))P.redraw_fake(usr)
			dark_skin
				icon_state="dark skin"
				Click()
					..()
					usr.skin_tone=2
					usr.redraw_character()
					for(var/turf/selectable/character_customize/platform/P in range(10,src))P.redraw_fake(usr)
			platform
				icon_state="platform"
				layer=91
				proc
					redraw_fake(var/mob/M)
						for(var/image/I in M.client.images)
							if(I.tag=="fake")del I
						var/image/I=image(M.icon,src)
						I.overlays=M.overlays


						I.tag="fake"
						I.dir=M.dir
						I.layer=92
						M << I
				MouseExited()
				MouseEntered()
		classes
			icon='Classes.dmi'
			Click()
				if(src.name=="Samurai")
					usr.skin_tone=1
					usr.redraw_character()
					spawn(0)usr.starter_clothes()
					usr.simplefadeout(0,5)
					sleep(5)
					usr.simplefadein(0,5)
					usr.class=src.name
					usr.loc=locate(10,65,1)
					sleep(5)
					for(var/turf/selectable/character_customize/platform/P in range(10,usr))
						P.redraw_fake(usr)
					..()
				else
					alert("This class isn't available yet, sorry ;(")
			New()
				var/obj/O=new/obj()
				O.layer=src.layer+1
				O.pixel_x=4
				O.pixel_y=-120
				O.maptext_width=120
				O.maptext_height=256
				O.maptext="<font color=#000000>[text_string] "
				src.pixel_x=0
				src.overlays+=O

			Samurai
				icon_state="samurai"
				text_string="<b>Samurai</b>\nThe Samurai is a legendary warrior of the sengoku era. The Samurai traditionally uses a katana blade and close ranged attacks to fight off enemies. Samurai Chi techniques lack range but are powerful. \n"
			Archer
				icon_state="archer"
				text_string="<b>Archer</b>\nThe Archer is a revered warrior of the sengoku era. The archer typically uses a bow and arrow - but skilled archers carry throwing knives and know basic martial arts. Archer Chi techniques are long ranged but lack power."
			Shinobi
				icon_state="shinobi"
				text_string="<b>Shinobi</b>\nThe Shinobi is a specialized assasin warrior who uses special skills to take down enemies. By using poison and martial arts, the shinobi is to be feared. Shinboi chi techniques are versatile but lack power. \n"
			Taoist
				icon_state="taoist"
				text_string="<b>Taoist</b>\nThe Taoist is an energy warrior who uses seals and magic to overwhelm his enemies. The Taoist carries no blade and relies soley on his ability to manipulate chi but has superior energy attacks. \n \n  "
		confirm_load
			icon_state="button"
			pixel_x=6
			pixel_y=4
			text_string="Confirm"
			Click()
				..()
				usr.logged=1
				usr.loc=locate(usr.lx,usr.ly,usr.lz)
				usr.mechanics()
				usr.login_message()
				usr.redraw_character()
				usr.can_move=1
				usr.fadeout_music()
				usr.play_music('MusicA.ogg')
				usr.song.volume=0
				usr.refresh_music()
				usr.fadein_music()
		new_game
			order=1
			icon_state="null"
			text_string="Begin Game"
		//	pixel_y=-6
			Click()
				..()
				usr.simplefadeout(0,5)
				sleep(5)
				usr.simplefadein(0,5)
				usr.set_name(usr.name)
				usr.loc=locate(11,47,1)
		/*		usr.mechanics()
				usr.login_message()
				usr.starter_clothes()
				usr.redraw_character()*/
		confirm
			order=2
			icon_state="button"
			text_string="Confirm"
			pixel_y=2
			pixel_x=18
			Click()
				if(usr.creating)return
				else
					usr.creating=1
				get_noob_name
					var/A=input("What is your surname?")as text
					var/B=length(A)
					if(B>25)
						alert(usr,"You cannot have a name longer than 25 characters.","Error")
						goto get_noob_name
					if(B<3)
						alert(usr,"Your name must be at least 3 characters long, sorry ;(","Error")
						goto get_noob_name
					usr.name=A
				usr.can_move=1
				usr.loc=locate(10,194,1)
				usr.mechanics()
				usr.redraw_character()
				usr.get_starter_skill()
				usr.test_save()
				usr.logged=1
				spawn(0)
					usr.play_sound('BEGINJOURNEY.wav')
					usr.fadeout_music()
					usr.play_music('MusicA.ogg')
					usr.song.volume=0
					usr.refresh_music()
					usr.fadein_music()
				usr.login_message()
				spawn(30)usr.client.show_notify("Hey [usr], heres a quick tip :\n\n You can talk to me or any other NPC by walking up to us and pressing space.","",100)

		load_game
			order=2
			icon_state="null"
			text_string="Continue"
		//	pixel_y=-6
			Click()
				..()
				if(usr.test_load())
					usr.lx=usr.x
					usr.ly=usr.y
					usr.lz=usr.z
					usr.loc=locate(10,29,1)
					for(var/turf/hud/bg2/B in range(5,usr))
						B.display_info(usr)
					for(var/turf/selectable/character_customize/platform/P in range(5,usr))P.redraw_fake(usr)
		del_game
			order=3
			icon_state="null"
			text_string="Delete"
			Click()
				usr.play_sound('MAINMENU.wav')
		//	pixel_y=-6
		options
			order=4
			icon_state="button"
			text_string="What is this?"