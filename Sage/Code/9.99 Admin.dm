var
	owner_key="IchiroKeisuke"
	list
		perm_ops=list()
		perm_mods=list()
		perm_gms=list()
		server_ops=list()
		server_mods=list()


mob
	var
		atom/recreate
	Login()
		..()
		spawn(0)src.admin_check()
	proc
		admin_check()
			if(src.key!=owner_key)
				src.verbs+=typesof(/mob/admin/owner/verb)
				src.verbs+=typesof(/mob/admin/moderator/verb)
				src.verbs+=typesof(/mob/admin/operator/verb/)
				src.verbs+=typesof(/mob/admin/game_master/verb/)
	admin
		owner		//highest rankng staff member, in charge of everything.
			verb
				get_levels()
					set name="Get Levels"
					set category="Admin"
					src.exp+=100
					var/x=25
					while(x>0)
						x--
						sleep(2)
						src.cap_exp()
				get_resources()
					set name="Get Resources"
					set category="Admin"
					src.wood+=100
					src.clay+=100
					src.ore+=100
					src.stone+=100
				god_mode()
					set name="God Mode"
					set category="Admin"
					usr.health=999999999999999999999
					usr.max_health=999999999999999999999
					usr.chi=99999999999999999999
					usr.max_chi=99999999999999999999
					usr.str=9999999999999999999
					usr.level=999999999999999999
		game_master		//high ranking staff member, in charge of heavy policing:Quick game fixes, strip/appoint authority.
			verb
				recreate()
					set name="Recreate"
					set category="Admin"
					var/atom/A=new src.recreate(src.loc)
					if(istype(A,/turf/))
						var/turf/T=A
						if(T.edge_state!="")
							T.create_edging(T)
				delete(var/atom/A)
					set name="Delete"
					set category="Admin"
					if(istype(A,/mob/))
						var/mob/M=A
						if(!M.client)
							del M
					else
						del A
				create()
					set name="Create"
					set category="Admin"
					var/A=input("What type of object do you want to create?","Creation")as anything in list("Mob","Obj","Turf","Cancel")
					if(A=="Mob")
						var/mob/B=input("What type of mob do you want to create?","Creation") as anything in typesof(/mob/)
						spawn(0)new B(src.loc)
						recreate=B
					if(A=="Obj")
						var/obj/OO=input("What type of object do you want to create?","Creation") as anything in typesof(/obj/)
						spawn(0)new OO(src.loc)
						recreate=OO
					if(A=="Turf")
						var/turf/C=input("What type of turf do you want to create?","Creation")as anything in typesof(/turf/)
						spawn(0)
							var/turf/CC=new C(src.loc)
							if(CC.edge_state!="")
								CC.create_edging(CC)
							recreate=C
		moderator		//mid ranking staff member, in charge of regular policing:hackers,excessive rulebreakers, reboots ect
			verb
				ghost_mode()
					set name="Ghost Mode"
					set category="Admin"
					switch(src.density)
						if(1)
							src.density=0
						if(0)
							src.density=1.
		operator			//lowest ranking staff member, in charge of minor policing:chat,help assistance ect.
			verb
				mute()
					set name="Mute"
					set category="Admin"
				unmute()
					set name="Unmute"
					set category="Admin"
				teleport()
					set name="Teleport"
					set category="Admin"
					var/X=input("X coordinate")as num
					var/Y=input("Y coordinate")as num
					var/Z=input("Z coordinate")as num
					var/B=input("Confirm Teleport to [X],[Y],[Z]","Confirm")as anything in list("Yes","No")
					if(B=="Yes")
						src.loc=locate(X,Y,Z)
						src.refresh_location()