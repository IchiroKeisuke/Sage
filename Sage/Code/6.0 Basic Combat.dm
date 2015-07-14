obj
	effects
		layer=20
		damage_number
			icon=null
			pixel_x=16
			pixel_y=16
			layer=99
			New(var/loca,var/sx,var/sy,var/dmg)
				loc=loca
				step_x=sx
				step_y=sy
				maptext="<font color=yellow>[round(dmg,0.1)]"
				spawn(0)fade_destroy()
			proc
				fade_destroy()
					set background=1
					while(alpha>0)
						alpha-=255/6
						pixel_y+=2
						sleep(1)
					del src
		tree_fell
			icon='trees.dmi'
			icon_state="t01"
			pixel_x=-80
			New()
				..()
			proc
				fell(var/A=1)
					var/dira=A
					while(alpha>0)
						alpha-=255/11
						pixel_x+=120/11*dira
						pixel_y-=100/11
						var/matrix/M=src.transform
						M.Turn(10*dira)
						src.transform=M
						sleep(1)
					del src
obj

	spawner
		icon=null
		logger
			New(var/loca,var/dira)
				loc=loca
				if(dira==1)
					dir=EAST
				else
					dir=WEST
				spawn_wood()
			proc
				spawn_wood()
					step_size=46
					var/A=pick(2,3)
					while(A>0)
						step(src,src.dir)
						var/obj/O=new/obj/interactable/log(src.loc)
						O.dir=src.dir
						A--
mob
	var
		interact=""
		can_attack=TRUE
		base_attack_delay=0.5
		soft_attack_delay=1.5
		combat_zone=0
		death_time=0
	key_down(k)
		..()
		switch(k)
			if("a")src.attack()
			if("z")auto_target()
			if("space")interact()
	var
		bleedout=0
		mob/target=null
	proc
		auto_target()
			if(target!=null)
				for(var/image/X in client.images)
					if(X.tag=="target")del X
				target=null
			else
				for(var/mob/M in orange(8,src))
					if(M!=src&&!istype(M,/mob/training))
						target=M
						var/image/I=image('miniHUD.dmi',M)
						I.icon_state="target"
						I.tag="target"
						I.layer=89
						I.pixel_y=32
						src << I
						src.target=M
						return
		bleedout(var/blood_num)
			set background=1
			if(bleedout!=0)
				bleedout+=blood_num
				if(bleedout>20)
					bleedout=20
				return
			else
				bleedout=blood_num
			while(bleedout>0)
				bleedout-=1
				spawn(0)new/obj/effects/small_effects/blood(src.loc)
				sleep(5)
		calculate_simple_damage()
			var/A=10+src.str*(0.1)+(rand(-15,15)/100)
			A*=(1+(src.str_buff))
			return A
		interact()
			for(var/obj/interactable/I in get_step(usr,usr.dir))
				I.interact()
			for(var/mob/npc/N in get_step(usr,usr.dir))
				N.interacted()
		handle_death()
			src.loc=locate(190,190,1)
			src.test_save()
			src.client.show_notify("It looks like your almost dead.. \n\n It looks like you will recover after about [src.level+10] seconds though..","reaper",50)
			death_time=world.realtime+(src.level+10)*10
			spawn((src.level+10)*10)
				if(src)
					src.loc=locate(100,100,2)
					src.health=src.max_health/2
					src.client.show_notify("It looks like you'll actually live, this time..","reaper",50)
		death()
			if(src.client)
				handle_death()
			else
				spawn(0)new/obj/effects/small_effects/body(src)
		death_check()
			if(health<=0)
				health=0
				death()
		damaged(var/dmg,var/mob/attacker)
			if(!combat_zone)return
			spawn(0)new/obj/effects/damage_number(src.loc,0,0,dmg)
			var/dira=src.dir
			src.pixel_step_away(src,attacker)
			src.dir=dira
			health-=dmg
			if(health<max_health/5)
				bleedout(rand(1,3))
			death_check()
			refresh_bars()//healthbar.update_bar(((health/max_health)*100),"HP:[health]/[max_health]")

		attack()
			if(!can_attack)return
			else can_attack=FALSE
			spawn(base_attack_delay+(soft_attack_delay*(100/agi)))can_attack=TRUE
			flick("punch",src)
			if(attack_mob())
				src.play_sound(pick('HitA.wav','HitB.wav','HitC.wav','HitD.wav','HitE.wav','HitF.wav','HitG.wav','HitH.wav','HitI.wav'))
				return
			else if(attack_tree())
				return
			else
				src.play_sound(pick('SwingA.wav','SwingB.wav','SwingC.wav','SwingD.wav'))
		face_target()
			if(target)
				src.dir=get_dir(src,target)
		attack_mob()
			src.step_size=32
			face_target()
			for(var/mob/M in get_step(src,src.dir) )
				if(M!=src)
					if(istype(M,/mob/training/dummy))
						var/mob/training/dummy/D=M
						D.train(src)
					var/damage=calculate_simple_damage()
					M.damaged(damage,src)
					return 1
			return 0

		attack_tree()
			var/atom/T=get_step(src,src.dir)
			if(T.name=="Tree")
				var/turf/terrain/tree/TT=T
				var/DMG=calculate_simple_damage()
				if(TT.felled)return 0
				TT.hp-=DMG
				new/obj/effects/damage_number(T,0,0,DMG)
				src << "You damaged the tree! ([TT.hp])"
				src.play_sound(pick('WoodA.wav','WoodB.wav','WoodC.wav','WoodD.wav'))
				if(TT.hp<=0)
					var/obj/effects/tree_fell/O=new/obj/effects/tree_fell(TT)
					var/dira=pick(-1,1)
					O.icon_state="[TT.tree_type]"
					spawn(0)O.fell(dira)
					TT.overlays=null
					TT.felled=1
					src.play_sound('TreeFell.wav')
					spawn(10)new/obj/spawner/logger(TT,dira)
					switch(TT.tree_type)
						if("t01")
							var/image/I=image('trees.dmi')
							I.icon_state="tr01"
							I.layer=20
							I.pixel_x=-80
							I.pixel_y=-5
							TT.overlays+=I
						if("t02")
							var/image/I=image('trees.dmi')
							I.icon_state="tr02"
							I.layer=20
							I.pixel_x=-80
							I.pixel_y=-5
							TT.overlays+=I
						if("t03")
							var/image/I=image('trees.dmi')
							I.icon_state="tr03"
							I.layer=20
							I.pixel_x=-80
							I.pixel_y=-5
							TT.overlays+=I
				return 1
			return 0
