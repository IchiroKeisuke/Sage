var/list/active_mobs=list()
world
	New()
		..()
		spawn(0)
		world_physics()
		spawn(0)
		world_AI()
	proc
		world_AI()
			loop
		//		for(var/mob/M in active_mobs)
			//		M.alert_monsters()
				spawn(20)
				goto loop
		world_physics()
			loop
				for(var/mob/M in active_mobs)
					spawn(0)
					M.physics()
				spawn(0.5)
				goto loop
mob
	var
		sprinting=0
	key_down(k)
		if(k == "r")
			src.toggle_run()
		else if(k=="i")
			src.toggle_inventory()
//		if(k=="shift")
//			src.toggle_sprint()
		if(k == "north")
			src.n=1
		else if(k == "south")
			src.s=1
		else if(k == "east")
			src.e=1
		else if(k == "west")
			src.w=1
	key_up(k)
//		if(k=="shift")
//			src.toggle_sprint()
		if(k == "north")
			src.n=0
		else if(k == "south")
			src.s=0
		else if(k == "east")
			src.e=0
		else if(k == "west")
			src.w=0
	New()
		..()
		spawn(0)
		if(client)
			active_mobs+=src
	Del()
		if(client)active_mobs-=src
		..()
	proc/physics_loop()
		loop
			spawn(0)
			physics()
			spawn(0.5)
			goto loop
	proc/physics_loop2()
		loop
			spawn(0)
			physics2()
			spawn(0.5)
			goto loop
	proc/physics2()
		var/D=src.dir
		if(src.vel_x<0)
			src.step_size=(-vel_x)
			vel_x++
			if(vel_x<-move_speed)
				vel_x++
			step(src,WEST)
		else if(src.vel_x>0)
			src.step_size=vel_x
			vel_x--
			if(vel_x>move_speed)
				vel_x--
			step(src,EAST)
		if(src.vel_y<0)
			src.step_size=(-vel_y)
			vel_y++
			if(vel_y<-move_speed)
				vel_y++
			step(src,SOUTH)
		else if(src.vel_y>0)
			src.step_size=(vel_y)
			vel_y--
			if(vel_y>move_speed)
				vel_y--
			step(src,NORTH)
		src.dir=D
	proc/physics()
		if(src.n==1)
			src.n()
		else if(src.s==1)
			src.s()
		if(src.e==1)
			src.e()
		else if(src.w==1)
			src.w()
		var/D=src.dir
		if(src.vel_x<0)
			src.step_size=(-vel_x)
			vel_x+=1
			if(vel_x<-move_speed)
				vel_x+=2
			step(src,WEST)
		else if(src.vel_x>0)
			src.step_size=vel_x
			vel_x-=1
			if(vel_x>move_speed)
				vel_x-=2
			step(src,EAST)
		if(src.vel_y<0)
			src.step_size=(-vel_y)
			vel_y+=1
			if(vel_y<-move_speed)
				vel_y+=2
			step(src,SOUTH)
		else if(src.vel_y>0)
			src.step_size=(vel_y)
			vel_y-=1
			if(vel_y>move_speed)
				vel_y-=2
			step(src,NORTH)
		src.dir=D
	proc
		n()
			if(!can_move)return
			if(vel_y<move_speed)vel_y+=2
			src.dir=NORTH
		s()
			if(!can_move)return
			if(vel_y>-move_speed)vel_y-=2
			src.dir=SOUTH
		w()
			if(!can_move)return
			if(vel_x>-move_speed)vel_x-=2
			src.dir=WEST
		e()
			if(!can_move)return
			if(vel_x<move_speed)vel_x+=2
			src.dir=EAST
		pixel_step_towards(var/mob/M,var/mob/MM)
			M.dir=get_dir(M,MM)
			M.pixel_step(M,M.dir)
		pixel_step_away(var/mob/M,var/mob/MM,var/xx=4)
			M.dir=get_dir(MM,M)
			M.pixel_step(M,M.dir,xx)
		pixel_step(var/mob/M,var/D,var/XX=4)
			if(D==NORTH)
				if(M.vel_y<13)M.vel_y+=XX
			else if(D==EAST)
				if(M.vel_x<13)M.vel_x+=XX
			else if(D==WEST)
				if(M.vel_x>-13)M.vel_x-=XX
			else if(D==SOUTH)
				if(M.vel_y>-13)M.vel_y-=XX
			else if(D==SOUTHEAST)
				if(M.vel_y>-13)M.vel_y-=XX
				if(M.vel_x<13)M.vel_x+=XX
			else if(D==NORTHEAST)
				if(M.vel_y<13)M.vel_y+=XX
				if(M.vel_x<13)M.vel_x+=XX
			else if(D==SOUTHWEST)
				if(M.vel_y>-13)M.vel_y-=XX
				if(M.vel_x>-13)M.vel_x-=XX
			else if(D==NORTHWEST)
				if(M.vel_y<13)M.vel_y+=4
				if(M.vel_x>-13)M.vel_x-=4