obj
	layer=11
	effects
		proc
			flick_die(var/A="",var/B=5)
				flick(A,src)
				spawn(B)del src
			expand_die(var/time=10,var/end_alpha=0,var/expand=1)
				var/x=0
				while(x<time)
					x++
					var/matrix/M=src.transform
					M.Scale(1+(expand/time),1+(expand/time))
					src.transform=M
					src.alpha-=((255-end_alpha)/10)
					sleep(1)
				del src
		New(var/loca,var/mob/ownera)
			loc=loca
			owner=ownera
			if(owner)
				step_x=owner.step_x
				step_y=owner.step_y
		small_effects
			icon='smalleffects.dmi'
			chat_notification
				layer=22
				icon_state="chat notification"
				pixel_y=24
				pixel_x=24
				New()
					..()
					spawn(0)flick_die("chat notification",5)
			smoke
				layer=60
				icon_state="smoke"
				New()
					..()
					spawn(0)expand_die(5,0,1)