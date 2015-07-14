obj
	system
		mob_spawner
			icon=null
			density=0
			var/mob/mob_path=null
			proc
				respawn()
					spawn(rand(1000,1500))
					new mob_path(src.loc)
mob
	proc
		AI_activation_loop()
			loop
				for(var/mob/combat_ready/C in orange(8,src))
					C.awaken()
				spawn(100)
				goto loop
	combat_ready
		str=2
		step_size=5
		var
			awake=0
			obj/system/mob_spawner/spawner
		New()
			..()
			spawner=new/obj/system/mob_spawner(src.loc)
			spawner.mob_path=src.type
			set_name("[src.name]")
		Del()
			spawner.respawn()
			..()
		boar
			icon='Boar.dmi'
			name="Boar"
			Del()
				..()
			death()
				drop_stuff(/obj/inventory/items/pork,rand(1,2))
				..()

		damaged(var/dmg,var/mob/attacker)
			spawn(0)awaken()
			spawn(0)
				var/dira=src.dir
				src.pixel_step_away(src,attacker)
				src.dir=dira
			spawn(0)new/obj/effects/damage_number(src.loc,0,0,dmg)
			health-=dmg
			if(health<max_health/5)
				bleedout(rand(1,3))
			death_check()
		death()
			spawn(0)
				new/obj/effects/small_effects/body(src)
			spawn(0)
				del src
		var
			simple_attack_delay=0
		proc
			drop_stuff(var/obj/O,var/num)
				var/x=0
				while(x<num)
					x++
					spawn(0)
						var/obj/A=new O(src.loc)
						A.alpha=25
						animate(A,pixel_x=rand(-16,16),pixel_y=rand(-16,16),alpha=255,rand(5,15))
			temp_physics()
				set background=1
				while(src.awake)
					src.physics2()
					sleep(0.5)
			awaken()
				spawn(0)simple_AI()
			deactivate()
				awake=0
			simple_attack()
				if(simple_attack_delay)return
				else
					simple_attack_delay=1
					spawn(3)
						if(src)
							simple_attack_delay=0
				if(get_dist(src,target)<=1)
					spawn(0)target.damaged(str,src)
					var/dira=target.dir
					target.pixel_step_away(target,src)
					target.dir=dira
					for(var/mob/M in range(3,src))
						M.play_sound(pick('HitA.wav','HitB.wav','HitC.wav','HitD.wav','HitE.wav','HitF.wav','HitG.wav','HitH.wav','HitI.wav'))

			simple_AI()
				set background=1
				if(awake)
					return 0
				else
					awake=1
					spawn(0)temp_physics()
				scan
					target=null
					for(var/mob/character/M in orange(5,src))
						target=M
						goto attack
					for(var/mob/character/M in orange(10,src))
						target=M
						goto attack
					deactivate()
					return
				attack
					if(prob(2)&&target!=null)
						spawn(0)target.play_sound(pick('OinkA.wav','OinkB.wav','OinkC.wav'))
					if(target&&get_dist(src,target)<15)
						if(prob(99.5))
							src.dir=get_dir(src,target)
							src.pixel_step(src,src.dir,3)
							simple_attack()
							sleep(1)
							goto attack
						else
							sleep(1)
						//	step_towards(src,target)
							goto charge
					sleep(0.5)
					goto scan
				charge
					flick("charge",src)
					sleep(12)
					src.pixel_step_towards(src,target,5)
					var/x=8
					while(x>0)
						x-=1
						spawn(0)new/obj/effects/small_effects/ghost_image(src)
						src.pixel_step_towards(src,target,2)
						sleep(0.5)
					src.icon_state="stun"
					sleep(20)
					src.icon_state=""
					goto attack
		Bump()
		//	for(var/mob/character/M in get_step(src,dir))
		//		if(prob(20))
		//			var/dira=M.dir
		//			spawn(0)M.damaged(str,src)
		//			M.pixel_step_away(M,src)
		//			M.dir=dira
		//			M.play_sound(pick('HitA.wav','HitB.wav','HitC.wav','HitD.wav','HitE.wav','HitF.wav','HitG.wav','HitH.wav','HitI.wav'))