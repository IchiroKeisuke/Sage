obj
	system
		re_edge
			New()
				..()
				spawn(5)
					for(var/turf/TT in range(1,src))
						TT.overlays=null
					for(var/turf/T in range(1,src))
						T.create_edging(T)
turf

	var
		turf/original_type
	proc
		revert_turf()
			spawn(0)new/obj/system/re_edge(src)
			spawn(1)new src.original_type(src)
		runtime_recreate_edging(var/turf/TT)
			TT.create_edging(TT)
	//		for(var/turf/T in range(1,src))
//				T.overlays=null
	//		for(var/turf/T in range(1,src))
		//		TT.create_edging(TT)
area
	construction
		icon='Map Tools.dmi'
		icon_state="construction"
		layer=100
		New()
			..()
			icon_state=null

mob
	var
		list
			wall_list=list()
			floor_list=list()
			other_list=list()
			utility_list=list()
			chosen_list=list()
	verb
		destroy_structure()
			set category=null
			var/turf/T=get_step(src,src.dir)
			if(T.owner==src.key)
				spawn(0)new/obj/effects/small_effects/smoke(T)
				spawn(0.5)T.revert_turf()
			for(var/mob/M in get_step(src,src.dir))
				if(M.owner==src)
					spawn(0)new/obj/effects/small_effects/smoke(M.loc)
					spawn(0.5)del M
			for(var/obj/O in get_step(src,src.dir))
				if(O.owner==src)
					spawn(0)new/obj/effects/small_effects/smoke(O.loc)
					spawn(0.5)del O
			winset(usr,"default.map1","focus=true")
		get_walls()
			set category=null
			chosen_list=usr.wall_list
			refresh_construction()
		get_floors()
			set category=null
			chosen_list=usr.floor_list
			refresh_construction()
		get_other()
			set category=null
			chosen_list=usr.other_list
			refresh_construction()
		get_utility()
			set category=null
			chosen_list=usr.utility_list
			refresh_construction()
	proc
		refresh_construction()
			var/count=0
			for(var/obj/constructors/C in usr.chosen_list)
				usr << output(C, "Construct.grid:[++count]")
			winset(src, "Construct.grid", "cells=\"[count]\"")
		init_basic_construction_tiles()
			usr.wall_list+=new/obj/constructors/walls/wood_stitchA()
			usr.floor_list+=new/obj/constructors/floors/hardwoodA()
			usr.floor_list+=new/obj/constructors/floors/hardwoodB()
			usr.wall_list+=new/obj/constructors/walls/paper_wallA()
			if(usr.construction_skill>5)
				usr.wall_list+=new/obj/constructors/walls/paper_wallB()
				usr.wall_list+=new/obj/constructors/walls/paper_wallC()
			usr.floor_list+=new/obj/constructors/floors/smoothwoodA()
			usr.floor_list+=new/obj/constructors/floors/smoothstoneA()
			usr.floor_list+=new/obj/constructors/floors/whitestone()
			if(usr.construction_skill>10)
				usr.wall_list+=new/obj/constructors/walls/wood_braceA()
				usr.wall_list+=new/obj/constructors/walls/wood_braceB()
				usr.wall_list+=new/obj/constructors/walls/stone_brickA()
				usr.floor_list+=new/obj/constructors/floors/claybrickA()
				usr.floor_list+=new/obj/constructors/floors/claybrickB()
				usr.floor_list+=new/obj/constructors/floors/metaltileA()
			usr.other_list+=new/obj/constructors/doors/paper_doorA()
			usr.other_list+=new/obj/constructors/doors/paper_doorB()
			usr.other_list+=new/obj/constructors/doors/paper_doorC()
			usr.utility_list+=new/obj/constructors/utility/training_dummy()
			usr.utility_list+=new/obj/constructors/utility/crafting_bench()
		init_learned_construction_tiles()
		construct_obj(var/obj/interactable/construction/C)
			var/X=1+(40/construction_skill)
			var/Y=0
			if(!C.check_resources(src))
				del C
				return
			if(collecting)
				del C
				return
			else
				collecting=1
				spawn(5+(200/construction_skill))collecting=0
			display_progressbar(5+(200/construction_skill))
			can_move-=1
			while(X>0)
				Y++
				src.play_sound(pick('PickaxeA.wav','PickaxeB.wav','PickaxeC.wav','PickaxeD.wav','PickaxeE.wav'))
				C.alpha+=(Y/(1+(40/construction_skill)))*250
				sleep(5)
				X--
			get_construction_exp(0.5)//usr << "Constructed : [C.name]"
			C.alpha=255
			C.take_resources(usr)
			usr.refresh_resources()
			can_move+=1
			C.created(usr)
			usr.save_resources()
		get_construction_exp(var/x)
			construction_skill+=x
			if(construction_skill>100)construction_skill=100
obj
	constructors
		var/obj/build_path
		Click()
			for(var/area/construction/C in range(0,usr))
				new build_path(usr.loc)
		walls
			icon='walls.dmi'
			stone_brickA
				name="Stone brick wall"
				build_path=/obj/interactable/construction/walls/stone_brickA
				icon_state="stone brickA"
			wood_stitchA
				name="Wood stitch wall"
				build_path=/obj/interactable/construction/walls/wood_stitchA
				icon_state="wood stitchA"
			wood_braceA
				name="Wood Brace Wall"
				build_path=/obj/interactable/construction/walls/wood_braceA
				icon_state="wood brace wallA"
			wood_braceB
				name="Wood Brace Wall"
				build_path=/obj/interactable/construction/walls/wood_braceB
				icon_state="wood brace wallB"
			paper_wallA
				name="Paper Wall"
				build_path=/obj/interactable/construction/walls/paper_wallA
				icon_state="paper wallA"
			paper_wallB
				name="Paper Wall"
				build_path=/obj/interactable/construction/walls/paper_wallB
				icon_state="paper wallB"
			paper_wallC
				name="Paper Wall"
				build_path=/obj/interactable/construction/walls/paper_wallC
				icon_state="paper wallC"
		floors
			icon='floors.dmi'
			hardwoodA
				name="Hardwood Floor"
				icon_state="hardwoodA"
				build_path=/obj/interactable/construction/floors/hardwoodA
			hardwoodB
				name="Hardwood Floor"
				icon_state="hardwoodB"
				build_path=/obj/interactable/construction/floors/hardwoodB
			smoothwoodA
				name="Smooth Wood Floor"
				icon_state="smooth woodA"
				build_path=/obj/interactable/construction/floors/smoothwoodA
			smoothstoneA
				name="Smooth Stone Floor"
				icon_state="smooth stoneA"
				build_path=/obj/interactable/construction/floors/smoothstoneA
			metaltileA
				name="Metal Plates"
				icon_state="metal tileA"
				build_path=/obj/interactable/construction/floors/metaltileA
			claybrickA
				name="Clay Brick"
				icon_state="clay brickA"
				build_path=/obj/interactable/construction/floors/claybrickA
			claybrickB
				name="Clay Brick"
				icon_state="clay brickB"
				build_path=/obj/interactable/construction/floors/claybrickB
			whitestone
				name="White Stone"
				icon_state="white stone"
				build_path=/obj/interactable/construction/floors/whitestone
		doors
			icon='walls.dmi'
			paper_doorA
				icon_state="paper doorA"
				build_path=/obj/interactable/construction/doors/paper_doorA
			paper_doorB
				icon_state="paper doorB"
				build_path=/obj/interactable/construction/doors/paper_doorB
			paper_doorC
				icon_state="paper doorC"
				build_path=/obj/interactable/construction/doors/paper_doorC
		utility
			icon='utility.dmi'
			training_dummy
				icon_state="training dummy"
				build_path=/mob/training/dummy
				Click()
					if(usr.wood<5)
						return
					else
						usr.wood-=5
					var/obj/A=new build_path(usr.loc)
					A.owner=usr
			crafting_bench
				icon_state="crafting bench"
				build_path=/obj/interactable/construction/utility/crafting_bench



	interactable
		construction
			New()
				..()
				src.alpha=50
				usr.construct_obj(src)
			var
				construction_density
				construction_time=15
				wood=0
				stone=0
				ore=0
				clay=0
				turf/construction/finish_path=/turf/construction
			proc
				check_resources(var/mob/M)
					if(M.wood<src.wood)return 0
					if(M.stone<src.stone)return 0
					if(M.ore<src.ore)return 0
					if(M.clay<src.clay)return 0
					return 1
				take_resources(var/mob/M)
					M.wood-=src.wood
					M.stone-=src.stone
					M.ore-=src.ore
					M.clay-=src.clay
					M.refresh_resources()
				created(var/mob/M)
					var/turf/TT=src.loc.type
					var/turf/T=new src.finish_path(src.loc)
					T.owner=M.key
					T.original_type=TT
					spawn(0)
						for(var/turf/TTT in range(1,src))
							TTT.create_edging(TTT)
					spawn(1)del src
			interact()

			walls
				icon='walls.dmi'
				construction_density=1
				stone_brickA
					icon_state="stone brickA"
					name="Stone Brick Wall"
					stone=3
					finish_path=/turf/construction/walls/stone_brickA
				wood_stitchA
					icon_state="wood stitchA"
					name="Wood Stitch Wall"
					wood=2
					finish_path=/turf/construction/walls/wood_stitchA
				wood_braceA
					icon_state="wood brace wallA"
					name="Wood Brace Wall"
					wood=3
					finish_path=/turf/construction/walls/wood_braceA
				wood_braceB
					icon_state="wood brace wallB"
					name="Wood Brace Wall"
					wood=3
					finish_path=/turf/construction/walls/wood_braceB
				paper_wallA
					icon_state="paper wallA"
					name="Paper Wall"
					wood=2
					finish_path=/turf/construction/walls/paper_wallA
				paper_wallB
					icon_state="paper wallB"
					name="Paper Wall"
					wood=2
					finish_path=/turf/construction/walls/paper_wallB
				paper_wallC
					icon_state="paper wallC"
					name="Paper Wall"
					wood=2
					finish_path=/turf/construction/walls/paper_wallC
			floors
				icon='floors.dmi'
				hardwoodA
					icon_state="hardwoodA"
					wood=1
					finish_path=/turf/construction/floors/hardwoodA
				hardwoodB
					icon_state="hardwoodB"
					wood=1
					finish_path=/turf/construction/floors/hardwoodB
				smoothwoodA
					icon_state="smooth woodA"
					wood=2
					finish_path=/turf/construction/floors/smoothwoodA
				smoothstoneA
					icon_state="smooth stoneA"
					stone=2
					finish_path=/turf/construction/floors/smoothstoneA
				metaltileA
					icon_state="metal tileA"
					ore=2
					finish_path=/turf/construction/floors/metaltileA
				claybrickA
					icon_state="clay brickA"
					clay=2
					finish_path=/turf/construction/floors/claybrickA
				claybrickB
					icon_state="clay brickB"
					clay=2
					finish_path=/turf/construction/floors/claybrickB
				whitestone
					icon_state="white stone"
					stone=2
					finish_path=/turf/construction/floors/whitestone
			doors
				icon='walls.dmi'
				var
					created=0
				paper_doorA
					icon_state="paper doorA"
					density=1
					wood=5
				paper_doorB
					icon_state="paper doorB"
					density=1
					wood=5
				paper_doorC
					icon_state="paper doorC"
					density=1
					wood=5
				created(var/mob/M)
					created=1
					owner=M
				interact()
					switch(src.density)
						if(1)
							src.density=0
							animate(src,pixel_x=-30,10)
							spawn(50)
								if(src.density==0)
									src.density=1
									animate(src,pixel_x=0,10)
						if(0)
							animate(src,pixel_x=0,10)
							src.density=1
			utility
				icon='utility.dmi'
				var
					created=0
				created(var/mob/M)
					created=1
				interact()
					if(created)
						usr << "Not in yet!"
					else
						..()
				crafting_bench
					icon_state="crafting bench"
					wood=5
					stone=5
					interact()
						if(created)
							usr.open_crafting_panel(src)
					//wood=5
turf
	construction
		edge_state="outline"
		walls
			icon='walls.dmi'
			density=1
			layer=10
			stone_brickA
				icon_state="stone brickA"
				name="Stone Brick Wall"
			wood_stitchA
				icon_state="wood stitchA"
				name="Wood Stitch Wall"
			wood_braceA
				icon_state="wood brace wallA"
				name="Wood Brace Wall"
			wood_braceB
				icon_state="wood brace wallB"
				name="Wood Brace Wall"
			paper_wallA
				icon_state="paper wallA"
				name="Paper Wall"
			paper_wallB
				icon_state="paper wallB"
				name="Paper Wall"
			paper_wallC
				icon_state="paper wallC"
				name="Paper Wall"
		floors
			layer=10
			icon='floors.dmi'
			hardwoodA
				icon_state="hardwoodA"
			hardwoodB
				icon_state="hardwoodB"
				layer=9.9
			smoothwoodA
				icon_state="smooth woodA"
				layer=10.1
			smoothstoneA
				icon_state="smooth stoneA"
				layer=10.2
			metaltileA
				icon_state="metal tileA"
				layer=10.3
			claybrickA
				icon_state="clay brickA"
				layer=10.4
			claybrickB
				icon_state="clay brickB"
				layer=10.5
			whitestone
				icon_state="white stone"
				layer=10.6
		utility
			icon='utility.dmi'
			var
				created=0

			crafting_bench
				icon_state="crafting bench"
				//wood=5