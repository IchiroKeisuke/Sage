mob
	var
		enter_world=0
turf
	system
		enter_world
			icon='landscape.dmi'
			icon_state="map edge"
			layer=99
			New()
				..()
				icon_state="nothing"
			Enter(var/atom/A)
				if(istype(A,/mob))
					var/mob/M=A
					if(M.enter_world)
						return
					M.enter_world=1
					var/B=input(usr,"Would you like to enter the world?","Confirm") as anything in list("Yes","No","Not yet")
					if(B=="Yes")
						M.simplefadeout(10,20)
						sleep(20)
						M.loc=locate(100,100,2)
						sleep(10)
						M.refresh_location()
						M.play_sound('NewGame.wav',30)
						M.simplefadein(10,20)
					M.can_move=1
					M.enter_world=0
		map_edge
			icon='landscape.dmi'
			icon_state="map edge"
			layer=99
			New()
				..()
				icon_state="nothing"
			Entered(var/atom/A)
				if(istype(A,/mob))
					var/mob/M=A
					relocate_mob(M)
					M.refresh_location()
			proc
				relocate_mob(var/mob/M)
					if(src.x==1)
						move_map(src,M,-1,0)
					else if(src.x==200)
						move_map(src,M,1,0)
					else if(src.y==1)
						move_map(src,M,0,-1)
					else if(src.y==200)
						move_map(src,M,0,1)
				move_map(var/turf/TT,var/mob/MM,var/xx,var/yy)
					var/X=src.x
					var/Y=src.y
					var/Z=src.z
					usr.simplefadeout(0,10)
					sleep(10)
					if(xx==1)
						X=3
						Z=Z+1
						MM.loc=locate(X,Y,Z)
					else if(xx==-1)
						X=197
						Z=Z-1
						MM.loc=locate(X,Y,Z)
					else if(yy==1)
						Y=3
						Z=Z+5
						MM.loc=locate(X,Y,Z)
					else if(yy==-1)
						Y=197
						Z=Z-5
						MM.loc=locate(X,Y,Z)
					usr.simplefadein(2,10)
					sleep(15)
				//	MM << "Z is [MM.z]"
	terrain
		layer=1
		icon='landscape.dmi'
		tree
			name="Tree"
			var
				felled=0
				tree_type="t01"
				hp=150
		cliff
			layer=5.1
			density=1
			edge_state="cliff edge"
			edge_group="cliff"
			icon_state="cliff"
		grass
			//layer=2
			New()
				..()
			grass_steps
				icon_state="grass steps"
				edge_state="grass01 edge"
				edge_group="grass01"
			grass01
				layer=5
				icon_state="grass01"
				edge_state="grass01 edge"
				edge_corners=TRUE
				edge_corner_state="grass01 edge2"
				edge_group="grass01"
				grass01_flowers
					icon_state="grass01 flowers"
				New()
					..()
					icon_state=pick("grass01","grass011")
			grass02
				layer=5.2
				icon_state="grass02"
				edge_state="grass02 edge"
			//	edge_corners=TRUE
			//	edge_corner_state="grass02 edge2"
				edge_group="grass02"
				grass02_flowers
					icon_state="grass02 flowers"
			grass03
				layer=6
				icon_state="grass03"
				edge_state="grass03 edge"
			grass04
		dirt
			layer=3
			dirt01
				icon_state="dirt01"
				edge_state="dirt01 edge"
			dirt02
				icon_state="dirt02"
				edge_state="dirt02 edge"
				layer=1.1
		pathway
			layer=3
			pathway01
				icon_state="pathway"
		water
			water01
				layer=9
				icon_state="water01"
				edge_state="water01 edge"
				edge_corner_state="water01 edge2"
				edge_corners=TRUE
				density=1
				New()
					..()
					spawn(0)icon_state=pick("water01","water02")
		stone
		//	icon='stone.dmi'
			layer=9.1
			stone01
				icon_state="stone01"
				edge_state="stone01 edge"
			cobblestone
				edge_state="cobblestone edge"
				icon_state="cobblestone"
obj
	details
		New()
			..()
			var/turf/T=src.loc
			var/image/I=image(src.icon)
			I.icon_state=src.icon_state
			I.layer=src.layer
			T.overlays+=I
			T.density=src.density
			del src
		icon='details.dmi'
		rock01
			icon_state="rock01"
			density=1
		rock02
			icon_state="rock02"
			density=1
		rock03
			icon_state="rock03"
			density=1
		rock04
			icon_state="rock04"
			density=1
		rock05
			icon_state="rock05"
			density=1
		flower01
			icon_state="flower01"
		flower02
			icon_state="flower02"
		flower03
			icon_state="flower03"
		flower04
			icon_state="flower04"
		flower05
			icon_state="flower05"
		flower06
			icon_state="flower06"
		grass_patch01
			icon_state="grass patch01"
		lily_pad01
			icon_state="lily pad01"
		lily_pad02
			icon_state="lily pad02"
		lily_pad03
			icon_state="lily pad03"

	foliage
		trees
			layer=20
			pixel_x=-80
			pixel_y=-20
			density=1
			name="Tree"
			New()
				spawn(10)
					var/turf/T=src.loc
					var/image/I=image(src.icon)
					I.icon=icon(src.icon,src.icon_state)
					I.pixel_x=src.pixel_x
					I.pixel_y=-5
					var/icon/II=icon(T.icon,T.icon_state)
					var/E=T.edge_state
					var/EE=T.edge_group

					var/III=T.icon_state
					var/turf/terrain/tree/TT=new /turf/terrain/tree(src.loc)
					TT.tree_type=src.icon_state
					I.layer=20
					TT.icon=II
					TT.icon_state=III

					TT.edge_state=E
					TT.edge_group=EE

					TT.overlays+=I
					TT.density=src.density
					del src
			icon='trees.dmi'
			t01
				icon_state="t01"
			t02
				icon_state="t02"
			t03
				icon_state="t03"