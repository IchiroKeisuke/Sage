mob
	var
		health=100
		max_health=100
		buff_health=0
		chi=100
		max_chi=100
		class="Taoist"
		clan="None"

		level=1
		exp=0
		max_exp=4

		str=10
		str_buff=0
		str_exp=0		//dictates physical dmg
		str_max_exp=1.1		//punch training dummies/use techniques that rely on strength.
		end=10			//remain in combat for long durations/recover energy/health.
		end_exp=0
		end_max_exp=1.1		//dictates max health/energy
		agi=10
		agi_exp=0			//dictates attack speed/running speed.
		agi_max_exp=1.1		//speed training / use techniques that rely on agility.
		int=10
		int_exp=0			//dictates magic dmg
		int_max_exp=1.1			//meditation/use techniques that rely on intelligence.
		wil=10
		wil_exp=0
		wil_max_exp=1.1		//determines regen rate/recovery rate after being defeated
		//resistance to debuffs/boosts recovery items/cooldown rates.
obj
	effects
		small_effects
			statup
				layer=60
				icon_state="statup"
				New()
					..()
					flick("statup",src)
					spawn(5)del src
			levelup
				layer=60
				icon_state="levelup"
				New()
					..()
					flick("levelup",src)
					spawn(5)del src
mob
	proc
		level_up()
			play_sound('LevelUp.wav')
			level++
			learn_skills()
			test_save()
			refresh_charactersheet()
			spawn(5)client.show_notify("You leveled up!([level])","level up",80)
			spawn(0)new/obj/effects/small_effects/levelup(src.loc)
		level_up_stat()
			play_sound('StatUp.wav')
			exp++
			cap_exp()
			refresh_charactersheet()
			spawn(0)new/obj/effects/small_effects/statup(src.loc)
		cap_exp()
			if(exp>max_exp)
				exp-=max_exp
				sleep(10)
				level_up()
		cap_int()
			if(int_exp>int_max_exp)
				int++
				int_exp-=int_max_exp
				int_max_exp=int_max_exp*1.05
				level_up_stat()
		cap_str()
			if(str_exp>str_max_exp)
				str++
				str_exp-=str_max_exp
				str_max_exp=str_max_exp*1.05
				level_up_stat()
		cap_agi()
			if(agi_exp>agi_max_exp)
				agi++
				agi_exp-=agi_max_exp
				agi_max_exp=agi_max_exp*1.05
				toggle_run()
				toggle_run()
				level_up_stat()
		str_exp(var/x)
			str_exp+=x
			cap_str()
		int_exp(var/x)
			int_exp+=x
			cap_int()
		agi_exp(var/x)
			agi_exp+=x
			cap_agi()
		cap_health()
			if(health>max_health)health=max_health
		cap_chi()
			if(chi>max_chi)chi=max_chi
		regen()
			loop
				health+=((max_health/200)+(max_health/200)*(wil/250))
				chi+=((max_chi/150)+(max_chi/150)*(wil/250))
				cap_health()
				cap_chi()
				refresh_bars()
				spawn(150)
				goto loop