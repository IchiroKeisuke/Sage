var
	list
		navi_npcs=list("Clan NPC","Head Monk")
		navi_regions=list("Kyoto","Western Mountains","Yamana Port")
obj
	system
		navi
			icon='HUD.dmi'
			icon_state="navi"
			var
				string=""
mob
	verb
		refresh_regions()
			set category=null
			var/count=0
			for(var/C in navi_regions)
				var/obj/system/navi/A=new/obj/system/navi()
				A.string=C
				A.name=C
				usr << output(A, "Pathfinding.grid:[++count]")
			winset(src, "PathFinding.grid", "cells=\"[count]\"")
		refresh_npcs()
			set category=null
			var/count=0
			for(var/C in navi_npcs)
				var/obj/system/navi/A=new/obj/system/navi()
				A.string=C
				A.name=C
				usr << output(A, "Pathfinding.grid:[++count]")
			winset(src, "Pathfinding.grid", "cells=\"[count]\"")