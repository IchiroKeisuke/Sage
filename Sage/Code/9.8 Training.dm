atom
	var
		mob/character/owner
mob
	training
		dummy
			icon='utility.dmi'
			icon_state="training dummy"
			damaged(var/dmg,var/mob/attacker)
				spawn(0)new/obj/effects/damage_number(src.loc,0,0,dmg)
			proc/train(var/mob/attacker)
				attacker.str_exp(1)

obj
	effects
		small_effects
			meditate
				icon_state="meditate"
	training
		chakra_mini_game
			icon='smalleffects.dmi'
			icon_state="bad chakra"
			layer=80
			Click()
				if(src.icon_state=="good chakra")
					src.icon_state="bad chakra"
					usr << 'ClickChakra.wav'
					usr.int_exp+=2
					usr.cap_int()
mob
	var
		obj/left_chak=null
		obj/mid_chak=null
		obj/right_chak=null
		obj/chak_switch=null
		med_game=1
		meditate=0
		med_state="rest"

	proc
		create_chak_game()
			usr.med_game=1
			var/obj/A=new/obj/training/chakra_mini_game()
			usr.left_chak=A
			A.screen_loc="9,10"
			usr.client.screen+=A
			var/obj/B=new/obj/training/chakra_mini_game()
			usr.mid_chak=B
			B.screen_loc="10,10"
			usr.client.screen+=B
			var/obj/C=new/obj/training/chakra_mini_game()
			C.screen_loc="11,10"
			usr.right_chak=C
			usr.client.screen+=C
		//	var/obj/D=new/obj/training/chakra_switch()
	//		D.screen_loc="10,7"
//			usr.chak_switch=D
//			usr.client.screen+=D
			usr.client.focus=usr
		chak_game()
			loop
				if(usr.right_chak)usr.right_chak.icon_state="bad chakra"
				else return
				if(usr.left_chak)usr.left_chak.icon_state="bad chakra"
				else return
				if(usr.mid_chak)usr.mid_chak.icon_state="bad chakra"
				else return
				var/A=pick(1,2,3)
				switch(A)
					if(1)
						usr.left_chak.icon_state="good chakra"
					if(2)
						usr.mid_chak.icon_state="good chakra"
					if(3)
						usr.right_chak.icon_state="good chakra"
				spawn(20)
					if(meditate)
						goto loop
		destroy_chak_game()
			del usr.left_chak
			del usr.mid_chak
			del usr.right_chak
			del usr.chak_switch