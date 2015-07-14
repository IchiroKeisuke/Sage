client
	proc
		show_notify(var/strin="",var/portrai="",var/tim=50)
			var/obj/GUI/notify/N=new/obj/GUI/notify()
			N.string=strin
			N.portrait=portrai
			N.time=tim
			N.activate(mob)




obj
	GUI
		notify
			layer=90
			icon='Notify.dmi'
			var
				string=""
				portrait=""
				time=50
			screen_loc="NORTH-2:24,EAST-7:-4"
			proc
				activate(var/mob/M)
					src.alpha=0
					create_text()
					create_portrait()
					M.client.screen+=src
					animate(src,alpha=255,time=6)
					sleep(time)
					animate(src,alpha=0,time=6)
					sleep(10)
					del src
				create_text()
					var/obj/O=new/obj()
					O.maptext="<font color=white><b>[string]"
					O.maptext_width=190
					O.maptext_height=64
					O.layer=91
					O.pixel_x=70
					O.pixel_y=3
					src.overlays+=O
				create_portrait()
					var/obj/GUI/portrait/P=new/obj/GUI/portrait()
					P.pixel_x=3
					P.pixel_y=3
					P.icon_state=src.portrait
					src.overlays+=P
		portrait
			layer=91
			icon='Portraits.dmi'
			pixel_x=3
			pixel_y=3