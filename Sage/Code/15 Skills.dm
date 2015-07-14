mob/character
	key_down(k)
		..()
		switch(k)
			if("1")use_skill(h1)
			if("2")use_skill(h2)
			if("3")use_skill(h3)
			if("4")use_skill(h4)
			if("5")use_skill(h5)
			if("q")use_skill(hq)
			if("w")use_skill(hw)
			if("e")use_skill(he)
proc
	calc_cd(var/hcd,var/scd,var/will)
		return (hcd+(scd*(10/will)))
mob/character
	var
		strike
		strike_hcd=20
		strike_scd=30
		strike_mastery=2
		strike_exp=0
		flash
		flash_hcd=60
		flash_scd=40
		flash_mastery=2
		flash_exp=0
		battle_scar
		battle_scar_hcd=50
		battle_scar_scd=50
		battle_scar_mastery=2
		battle_scar_exp=0
		pulsar
		pulsar_hcd=50
		pulsar_scd=50
		pulsar_mastery=2
		pulsar_exp=0
		flicker
		flicker_hcd=60
		flicker_scd=60
	proc
		use_skill(var/A)
			switch(A)
				if("Meditate")meditate()
				if("Strike")strike()
				if("Flash Assult")flash()
				if("Battle Scar")battle_scar()
				if("Flicker")flicker()
				if("Pulsar")pulsar()
				else
					return
		strike_mastery()
			switch(strike_mastery)
				if(1)
					usr << "<b><font color=green>You have achieved an intermediate strike technique. You now release a slightly larger burst and deal increased dmg."
				if(2)
					usr << "<b><font color=green>You have achieved a level of mastery with the strike technique. You now release a superior bursts and dmg for this technique."

		train_strike()
			str_exp(0.1)
			strike_exp++
			if(strike_mastery==2)
				return
			else
				if(strike_mastery==0&&strike_exp>30)
					strike_mastery++
					strike_mastery()
				else if(strike_exp>100)
					strike_mastery++
					strike_mastery()
		train_flash()
			str_exp(0.15)
		train_battle_scar()
			str_exp(0.2)
		train_pulsar()
			str_exp(0.25)


		meditate()
			set category=null
			if(meditate==1)
				can_attack=1
				meditate=0
				can_move=1
				icon_state=med_state
				usr.overlays-=new/obj/effects/small_effects/meditate()
				destroy_chak_game()
			else
				med_state=icon_state
				can_attack=0
				icon_state="rest"
				meditate=1
				can_move=0
				usr.overlays+=new/obj/effects/small_effects/meditate()
				create_chak_game()
				chak_game()
		//meditate()
	//		usr << "successful"
		flicker()
			if(flicker)return
			flicker=1
			agi_exp(0.2)
			spawn(calc_cd(flicker_hcd,flicker_scd,src.wil))flicker=0


			move_speed+=20
			spawn(0)src.pixel_step(src,src.dir,30)
			move_speed-=20
			var/x=6
			while(x>0)
				spawn(0)new/obj/effects/small_effects/ghost_image(src)
				x--
				sleep(0.5)
		pulsar()
			if(pulsar)return
			pulsar=1
			spawn(calc_cd(pulsar_hcd,pulsar_scd,src.wil))pulsar=0
			train_pulsar()

			spawn(0)new/obj/techniques/samurai/pulsar(src,NORTH)
			spawn(0)new/obj/techniques/samurai/pulsar(src,SOUTH)
			spawn(0)new/obj/techniques/samurai/pulsar(src,WEST)
			spawn(0)new/obj/techniques/samurai/pulsar(src,EAST)
			spawn(0)new/obj/techniques/samurai/pulsar(src,NORTHEAST)
			spawn(0)new/obj/techniques/samurai/pulsar(src,NORTHWEST)
			spawn(0)new/obj/techniques/samurai/pulsar(src,SOUTHWEST)
			spawn(0)new/obj/techniques/samurai/pulsar(src,SOUTHEAST)
		flash()
			if(flash)return
			flash=1
			spawn(calc_cd(flash_hcd,flash_scd,src.wil))flash=0
			train_flash()
			face_target()
			spawn(0.5)flick("punch",src)
			move_speed+=10
			spawn(0)src.pixel_step(src,src.dir,25)
			move_speed-=10
			var/x=3
			while(x>0)
				spawn(0)new/obj/effects/small_effects/ghost_image(src)
				x--
				sleep(1)
			spawn(1)
				face_target()
				for(var/mob/M in get_step(src,src.dir))
					if(M!=src)
						spawn(0)M.damaged(src.calculate_simple_damage()*(1.5+(0.5*flash_mastery)),src)
						M.pixel_step_away(M,src,12)
			sleep(2)
			face_target()
			spawn(0.5)flick("kick",src)
			move_speed+=5
			spawn(0)src.pixel_step(src,src.dir,15)
			move_speed-=5
			spawn(0)new/obj/effects/small_effects/ghost_image(src)
			spawn(1)
				face_target()
				for(var/mob/M in get_step(src,src.dir))
					if(M!=src)
						spawn(0)M.damaged(src.calculate_simple_damage()*(1.5+(0.5*flash_mastery)),src)
						M.pixel_step_away(M,src,25)
		strike()
			if(strike)return
			strike=1
			spawn(calc_cd(strike_hcd,strike_scd,src.wil))strike=0
			train_strike()

			flick("punch",src)
			spawn(0)new/obj/techniques/samurai/strike(src)
			spawn(0)new/obj/techniques/samurai/strike_mark(get_step(src,src.dir))
			for(var/mob/M in get_step(src,src.dir) )
				if(M!=src)
					var/damage=calculate_simple_damage()
					spawn(0.5)M.damaged(damage*(2+(strike_mastery/2)),src)
					spawn(0)new/obj/techniques/samurai/strike/burst(M.loc,NORTH)
					spawn(0)new/obj/techniques/samurai/strike/burst(M.loc,SOUTH)
					spawn(0)new/obj/techniques/samurai/strike/burst(M.loc,WEST)
					spawn(0)new/obj/techniques/samurai/strike/burst(M.loc,EAST)
					return
			return 0
		battle_scar()
			if(battle_scar)return
			battle_scar=1
			spawn(calc_cd(battle_scar_hcd,battle_scar_scd,src.wil))battle_scar=0
			train_battle_scar()

			flick("punch",src)

			new/obj/techniques/samurai/battle_scar(src)
obj
	techniques
		samurai
			layer=40
			pulsar
				icon='small_techniques.dmi'
				icon_state="pulsar"
				step_size=8
				density=1
				New(var/mob/character/M,var/dira)
					src.loc=M.loc
					src.step_x=M.step_x
					owner=M
					src.step_y=M.step_y
					src.dir=dira
					step(src,src.dir)
					spawn(0)animate(src,alpha=0,time=(2+M.pulsar_mastery))
					spawn(0)walk(src,src.dir)
					spawn(2+M.pulsar_mastery)del src
				Move()
					spawn(0)
						if(src.owner.pulsar_mastery==2)
							var/obj/O=new/obj/techniques/samurai/battle_scar_trail2(src.loc)
							O.dir=src.dir
							O.step_x=src.step_x
							O.step_y=src.step_y
					spawn(0)..()
				Bump()
					for(var/mob/M in get_step(src,src.dir))
						var/dira=M.dir
						M.pixel_step_away(M,src)
						M.dir=dira
						M.damaged(M.calculate_simple_damage(),owner)
					..()
			battle_scar
				icon='small_techniques.dmi'
				icon_state="battle scar"
				step_size=32
				density=1
				New(var/mob/character/M)
					src.loc=M.loc
					src.step_x=M.step_x
					owner=M
					src.step_y=M.step_y
					src.dir=M.dir
					step(src,src.dir)
					spawn(1)animate(src,alpha=125,time=(2+M.battle_scar_mastery/2))
					spawn(0)walk(src,src.dir)
					spawn(2+M.battle_scar_mastery/2)del src
				Move()
					spawn(0)
						var/obj/O=new/obj/techniques/samurai/battle_scar_trail(src.loc)
						O.icon_state="battle scar trail_[owner.battle_scar_mastery+1]"
						O.dir=src.dir
						O.step_x=src.step_x
						O.step_y=src.step_y
					spawn(0)..()
				Bump()
					for(var/mob/M in get_step(src,src.dir))
						var/dira=M.dir
						M.pixel_step_away(M,src)
						M.dir=dira
						M.damaged(M.calculate_simple_damage(),owner)
					..()
			battle_scar_trail
				icon='small_techniques.dmi'
				icon_state="battle scar trail"
				density=0
				layer=15
				New()
					..()
					spawn(5) del src
				Del()
					animate(src,alpha=0,time=5)
					sleep(5)
					..()
			battle_scar_trail2
				icon='small_techniques.dmi'
				icon_state="battle scar trail"
				density=0
				layer=15
				New()
					..()
					spawn(3) del src
				Del()
					animate(src,alpha=0,time=5)
					sleep(3)
					..()
			strike
				icon='small_techniques.dmi'
				icon_state="strike_1"
				density=0
				step_size=16
				New(var/mob/character/M)
					src.loc=M.loc
					switch(M.strike_mastery)
						if(0)icon_state="strike_1"
						if(1)icon_state="strike_2"
						if(2)icon_state="strike_3"
					src.step_x=M.step_x
					src.step_y=M.step_y
					src.dir=M.dir
					spawn(0)walk(src,src.dir)
					spawn(2)del src
				burst
					step_size=14
					New(var/loca,var/dira)
						var/mob/character/M=usr
						switch(M.strike_mastery)
							if(0)icon_state="strike_1"
							if(1)icon_state="strike_2"
							if(2)icon_state="strike_3"
						src.loc=loca
						src.dir=dira
						spawn(0)walk(src,dira)
						spawn(4)del src
			strike_mark
				icon='small_techniques.dmi'
				icon_state="strike"
				density=0
				New()
					..()
					if(usr)
						step_x=usr.step_x
						step_y=usr.step_y
					spawn(5)
						var/x=5
						while(x>0)
							x--
							alpha-=40
							sleep(1)
						del src