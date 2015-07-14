var
	screenfx_view_width=14.5
	screenfx_view_hwight=9.5
client
	var/list/L=list()
	proc
		screen_get(var/input_name="")
			for(var/obj/O in L)
				if(O.name==input_name)
					return O
		screen_set(var/input_name="",var/target_alpha)
			for(var/obj/O in L)
				if(O.name==input_name)
					O.alpha=target_alpha
		screen_fade(var/input_name="",var/target_alpha,var/target_ticks)
			for(var/obj/O in L)
				if(O.name==input_name)
					var/rate=(O.alpha-target_alpha)/target_ticks
					loop
						if(!O)
							return
						else if(O.alpha!=target_alpha)
							O.alpha-=rate
							spawn(0.1)
							goto loop
						else
							return
		screen_create(var/input_name="",var/icon/II,var/state="")
			var/obj/O=new/obj()
			O.icon=II
			O.icon_state=state
			O.name=input_name
			O.layer=99
			L+=O
			O.screen_loc="CENTER-1:-16,CENTER-1:-16"
			screen+=O
			var/icon/I=icon(O.icon)
			if(I!=null)
				var/width=I.Width()
				var/hwight=I.Height()
				var/matrix/M=matrix()
				M.Scale((((screenfx_view_width*64+32)/width)),(((screenfx_view_hwight*64+32)/hwight)))
				O.transform=M
			else
				src << "no proper icon provided for [O]"
		screen_destroy(var/input_name="")
			for(var/obj/O in L)
				if(O.name==input_name)
					L-=O
					del O