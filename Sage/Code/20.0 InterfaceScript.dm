mob
	proc
		set_name(var/A="")
			var/obj/O=new/obj()
			O.name="nametag"
			O.maptext={"<SPAN style="color:white;font-family:calibri;">[A]</SPAN>"}
			O.maptext_width=length(A)*9
			O.maptext_height=64
			O.pixel_y=-20
			O.pixel_x=-length(A)*1.5+8
			O.layer=89
			O.alpha=100
			src.overlays+=O


mob
	var
		inventory_open=FALSE
		charactersheet_open=FALSE
		resources_open=FALSE
		construct_open=FALSE
		stats_open=FALSE
		pathfinding_open=FALSE
	verb
		toggle_pathfinding()
			set category=null
			if(pathfinding_open)
				close_pathfinding()
			else
				open_pathfinding()
		open_pathfinding()
			set category=null
			pathfinding_open=TRUE
			winshow(src,"PathFinding",1)
		close_pathfinding()
			set category=null
			pathfinding_open=FALSE
			winshow(src,"PathFinding",0)
		display_standard()
			set category=null
			winset(usr,"default.map1","icon-size=64")
		display_stretch()
			set category=null
			winset(usr,"default.map1","icon-size=0")
		display_half()
			set category=null
			winset(usr,"default.map1","icon-size=32")
		toggle_fullscreen()
			set category=null
			usr.client.toggle_fullscreen()
		refresh_construct()
			set category=null
			winset(usr,"Resources.wood","text=[usr.wood]")
			winset(usr,"Resources.stone","text=[usr.stone]")
			winset(usr,"Resources.ore","text=[usr.ore]")
			winset(usr,"Resources.clay","text=[usr.clay]")
		toggle_stats()
			set category=null
			if(stats_open)
				close_stats()
			else
				open_stats()
		open_stats()
			set category=null
			stats_open=TRUE
			winshow(src,"Stats",1)
		close_stats()
			set category=null
			stats_open=FALSE
			winshow(src,"Stats",0)
		toggle_construct()
			set category=null
			if(construct_open)
				close_construct()
			else
				open_construct()
		open_construct()
			set category=null
			construct_open=TRUE
			refresh_construct()
			winshow(src,"Construct",1)
		close_construct()
			set category=null
			construct_open=FALSE
			winshow(src,"Construct",0)
		refresh_resources()
			set category=null
			winset(usr,"Resources.wood","text=[usr.wood]")
			winset(usr,"Resources.stone","text=[usr.stone]")
			winset(usr,"Resources.ore","text=[usr.ore]")
			winset(usr,"Resources.clay","text=[usr.clay]")
		toggle_resources()
			set category=null
			if(resources_open)
				resources_open=FALSE
				close_resources()
			else
				resources_open=TRUE
				open_resources()
		open_resources()
			set category=null
			resources_open=TRUE
			refresh_resources()
			winshow(src,"Resources",1)
		close_resources()
			set category=null
			resources_open=FALSE
			winshow(src,"Resources",0)
		toggle_charactersheet()
			set category=null
			if(charactersheet_open)
				charactersheet_open=FALSE
				close_charactersheet()
			else
				charactersheet_open=TRUE
				open_charactersheet()
		open_charactersheet()
			set category=null
			charactersheet_open=TRUE
			refresh_charactersheet()
			winshow(src,"CharacterSheet",1)
		close_charactersheet()
			set category=null
			charactersheet_open=FALSE
			winshow(src,"CharacterSheet",0)
		toggle_inventory()
			set category=null
			if(inventory_open)
				inventory_open=FALSE
				close_inventory()
			else
				inventory_open=TRUE
				open_inventory()
		close_inventory()
			set category=null
			inventory_open=FALSE
			src<<'close_inventory.wav'
			winshow(src,"Inventory",0)
		open_inventory()
			set category=null
			inventory_open=TRUE
			src<<'open_inventory.wav'
			winshow(src,"Inventory",1)
			refresh_inventory()
		get_who()
			set category=null
			get_who_list()
		guide()
			set category=null

			var/guide={"
			<b><u>Basic Controls</u><br/>
			Arrow Keys - Movement<br/>
			Space - Interact<br/>
			<br/>
			A - Attack<br/>
			Z - Auto Target (nearest enemy)<br/>
			1-5,Q-E Skills<br/>
			<br/>

		<b>	<u>Starting Out</u><br/>
			If you are new to sandbox RPG's or want to get a feel for the game you should take the tutorial after starting the game. You can interact with pretty much anything(including NPC's) by pressing space.
			<br/><br/>

			<u>Training</u><br/>
			As of 0.5 there are only two types of training and stats that are fully functioning - Strength and Intelligence. You can raise strength by using skills that require strength and you can raise intelligence by meditating(also a skill) and by using skills that require intelligence.
			<br/><br/>You can view your character status by clicking on the character status icon in the lower right hand corner of the interface.
			<br/><br/>You can acess your skills by clicking on the quick panel icon in the lower right hand corner of the interface.
			<br/><br/>
			<u>Gaining New Skills</u><br/>
			As of 0.5 only class and naturally learned skills are available - this means all you need to do to learn any skills is to level up. Class skills are learned every 5 levels while naturally learned skills are learned at seperate, varying levels.
			<br/><br/>
			<u>Mastering Skills</u><br/>
			As of 0.5 there is a mastery system in place that allows your skills to evolve over time. When you first learn a skill, it is in it's base form.
			<br/><br/>
			Over time, as you use your skills your mastery over that skill will increase. After you have used a skill a certain number of times (depending on the skill) your skill will reach an elevated state. This continues until you have mastered that skill. Most skills usually have 1-3 Evolved forms.
			<br/><br/>
			<u>Resources</u><br/>
			You can view your resources by clicking on the resources icon in the lower right hand corner of the interface.
			<br/><br/>
			You can gain resources in various ways : Wood can be gathered by chopping up trees. Clay can be gathered in clay pits. Stone and Ore can be gathered in mines.
			<br/>
			Different Areas have different natural resources, so don't be afraid to adventure out into uncharted territory!
			<br/><br/>
			<u>Currency</u><br/>
			The currency system in SRPG works similar to the currency system of Sengoku era Japan : Mon is the equivalent of "cents" and Ryo is the equivalent of "dollars" (in the US currency system).<br/><br/>
			 One Ryo is said to be enough money to feed a man for an entire year. One Ryo is worth 2000 Mon instead of 100 like in the US system. To give you a frame of referance, One Ryo is worth about 2000 US Dollars, So 1 mon is worth about 1 modern dollar.
			 <br/>
			<u>Construction</u><br/>
			As of 0.5 Players are allowed to construct their own houses and structures. You can open the construction menu by clicking on the Construction icon in the lower right hand corner of the screen.
			<br/><br/>
			You can click on any category to display listed construction items. Your character will learn how to construct more advanced buildings as their construction skill level rises. So don't worry if you dont' see very many things just yet.
			<br/><br/>
			<u>Crafting</u><br/>
			The crafting system in Sage is very easy and straightforward. Like construction, more recipes are learned over time.

			<br/><br/>To craft an item, build a crafting bench at your home(or use a public one) and click on the desired recipe, make sure you have the resources that are listed and then click craft to craft your item. You can craft in bulk by specifying a quantity.

			<br/><br/>
			<u>Wild Animals/Mobs</u><br/>
			Many wild animals and creatures can be found in SRPG, Boars and Deer roam the forest. Spirits and Demons lurk in the shadows. Bandits roam the trading routes.
			<u></u>
			"}


			var/C=usr.popwindow("Guide","[guide]. <br/>")
			usr << browse(C,"window=Guide;size=450x325;titlebar=1;border=0;can_close=0;can_resize=0;can_minimize=0;")
			usr.popwindow_response()
			usr << browse(null,"window=Guide")
client
	proc
		toggle_fullscreen()
			var/toggle=winget(src,"default","is-maximized")
			if(toggle=="true")
				winset(src,"default","is-maximized=false")
				winset(src,"default","Titlebar=true")
			else
				winset(src,"default","is-minimized=true")
				winset(src,"default","Titlebar=false")
				winset(src,"default","is-maximized=true")
