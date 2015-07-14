obj
	code_objects			//anything that doesn't need to be mapped at any point in time.
		nametag
			layer=90
			pixel_y=-16
			maptext_width=256
mob
	var
		obj
			nametag		//keeps track of the nametag
	proc
		add_nametag()
			if(nametag)				//in case we happen to already have one.
				src.overlays-=nametag

			src.nametag=new/obj/code_objects/nametag()
			src.nametag.maptext=src.name
			src.nametag.pixel_x=-length(src.name)*2 //simple way to center the text
			src.overlays+=nametag
		remove_nametag()
			if(nametag)
				src.overlays-=nametag
				del src.nametag