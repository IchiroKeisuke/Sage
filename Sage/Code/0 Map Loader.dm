obj
	var
		sx
		sy
		sz
world
	New()
		spawn(0)load_map()
		..()
	Del()
		save_map()
		..()
//mob/admin
//	verb
//		save_m()
//			world.save_map()
//		load_m()
//			world.load_map()


world/proc
	save_map()
		var/savefile/F=new("WorldMap")
		var/list/L=list()
		var/list/LL=list()
		for(var/turf/construction/C in world)
			world << "Turf found!"
			L+=C
			F["[C.x][C.y][C.z]1"]<<C.owner
			F["[C.x][C.y][C.z]2"]<<C.original_type
		for(var/obj/inventory/items/placed/P in world)
			P.sx=P.x
			P.sy=P.y
			P.sz=P.z
			LL+=P
		F["A"]<<L
		F["B"]<<LL
	load_map()
		var/savefile/F=new("WorldMap")
		if(F)
			world << "Map Found"
			var/list/L=list()
			F["A"]>>L
			sleep(5)
			for(var/turf/construction/C in world)
				world << "[F["[C.x][C.y][C.z]1"]] [F["[C.x][C.y][C.z]2"]]"
				F["[C.x][C.y][C.z]1"]>>C.owner
				F["[C.x][C.y][C.z]2"]>>C.original_type
			var/list/LL=list()
			F["B"]>>LL
			for(var/obj/O in LL)
				O.loc=locate(O.sx,O.sy,O.sz)
		else
			world << "Map not found"