mob
	Login()
		..()
	proc
		get_skills()
			for(var/obj/skill_cards/non_class/meditate/A in contents)
				return
			var/obj/skill_cards/non_class/C=new/obj/skill_cards/non_class/meditate()
			C.learn(src)
		get_starter_skill()
			switch(class)
				if("Samurai")
					var/obj/skill_cards/class/samurai/strike/S=new/obj/skill_cards/class/samurai/strike()
					S.learn(src)
		learn_skills()
			if(level==5)
				var/obj/skill_cards/class/samurai/flash_assult/SS=new/obj/skill_cards/class/samurai/flash_assult()
				SS.learn(src)
			if(level==10)
				var/obj/skill_cards/class/samurai/battle_scar/SSS=new/obj/skill_cards/class/samurai/battle_scar()
				SSS.learn(src)
			if(level==15)
				var/obj/skill_cards/class/samurai/flicker/SSSS=new/obj/skill_cards/class/samurai/flicker()
				SSSS.learn(src)
			if(level==20)
				var/obj/skill_cards/class/samurai/pulsar/SSSSS=new/obj/skill_cards/class/samurai/pulsar()
				SSSSS.learn(src)
		set_skill(var/A,var/B)
			switch(A)
				if("H1")h1=B
				if("H2")h2=B
				if("H3")h3=B
				if("H4")h4=B
				if("H5")h5=B
				if("HQ")hq=B
				if("HW")hw=B
				if("HE")he=B
				else
					src << "Error : Hotslot not found."
					return

obj
	skill_cards
		icon='skillcards.dmi'
		New()
			..()
			mouse_drag_pointer=icon(src.icon,src.icon_state)
		MouseDrop(var/atom/A)
			if(istype(A,/obj/HUD/hotslot))
				var/obj/HUD/hotslot/C=A
				C.icon_state=src.icon_state
				usr.set_skill(C.name,src.skill)
		Click()
			var/mob/character/M=usr
			M.use_skill(src.skill)
		var
			req_exp=100
			learn_delay=120
			skill=""
			learn_message=""
			description=""
		proc
			learn(var/mob/M)
				src.loc=M
				M << "<font color=green><b>[learn_message]"
		non_class
			meditate
				name="Meditate"
				icon_state="meditate"
				skill="Meditate"
				learn_message="You have learned how to channel chi."
		class
			samurai
				pulsar
					name="Turtle Shell : Rupture"
					icon_state="pulsar"
					skill="Pulsar"
					learn_message="You have learned Turtle Shell : Rupture! This samurai chi technique rapidly expands and ruptures your turtle shell shield and releases a shockwave from your body that will crush nearby enemies. This technique requires that you have an active turtle shell shield and does damage based on the amount of shield energy left."
				flicker
					name="Body Flicker"
					icon_state="flicker"
					skill="Flicker"
					learn_message="You have learned how to utilize your internal energy in order to give you a short, powerful boost of agility."
				battle_scar
					name="Battle Scar"
					icon_state="battle scar"
					skill="Battle Scar"
					learn_message="You have learned Heavens Gale! This samurai chi technique lets you close your chakras and bottle up your energy then re-open them quickly to create a chi shockwave that forces enemies back."
				flash_assult
					name="Heavens Fury"
					icon_state="flash assult"
					skill="Flash Assult"
					learn_message="You have learned Heavens Fury! By taking advantage of your bodies physical stanima and strength you can now unleash a series of melee attacks in rapid sucession."
				strike
					name="Heavy Strike"
					icon_state="strike"
					skill="Strike"
					learn_message="You have learned Heavy Strike! This samurai technique relies on relaxing then tensing your arm in order to focus all of your strength into a single strike."