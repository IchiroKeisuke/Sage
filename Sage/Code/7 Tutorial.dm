mob
	var
		tutorial=1
	npc
		proc
			talk_to(var/mob/M,var/T)
				spawn(0)M.play_sound('Pling.wav')
				spawn(0)new/obj/effects/small_effects/chat_notification(src.loc)
				usr << "<b>NPC : </b>[T]"
		reaper
			icon='reaper.dmi'
			layer=90
			interacted(var/mob/M)
				if(death_time<world.realtime)
					M.loc=locate(100,100,2)
					M.health=M.max_health/2
					M.client.show_notify("It looks like you'll actually live, this time..","reaper",50)
				else
					talk_to(M,"I'm afraid your still on the brink of death [usr].")

		damaged(var/dmg,var/mob/attacker)
		pixel_x=0
		pixel_y=0
		set_name(var/A="")
			var/obj/O=new/obj()
			var/obj/OO=new/obj()
			var/obj/OOO=new/obj()
			O.name="nametag"
			O.maptext={"<SPAN style="color:white;font-family:calibri;"><b>[A]</SPAN>"}
			O.maptext_width=length(A)*9
			O.maptext_height=64
			O.pixel_y=32
			O.pixel_x=-length(A)*1.5
			O.layer=89
			O.alpha=255
			OO.name="nametag"
			OO.maptext={"<SPAN style="color:black;font-family:calibri;"><b>[A]</SPAN>"}
			OO.maptext_width=length(A)*9
			OO.maptext_height=64
			OO.pixel_y=-1
			OO.pixel_x=1
			OO.layer=88
			OO.alpha=255
			OOO.name="nametag"
			OOO.maptext={"<SPAN style="color:black;font-family:calibri;"><b>[A]</SPAN>"}
			OOO.maptext_width=length(A)*9
			OOO.maptext_height=64
			OOO.pixel_y=1
			OOO.pixel_x=-1
			OOO.layer=88
			OOO.alpha=255
			O.overlays+=OOO
			O.overlays+=OO
			O.alpha=255
			src.overlays+=O
		proc
			interacted()
		tutorial
			icon='Tutorial.dmi'
			name="Tutorial NPC"
			New()
				..()
				set_name(src.name)
			npc1
				name="Tutorial NPC 1"
				damaged(var/dmg,var/mob/attacker)
					if(attacker.tutorial==4)
						spawn(0)
							attacker.tutorial=5
							talk_to(usr,"Good job!")
							sleep(15)
							talk_to(usr,"You can change the display or sound settings using the menus at the top of the game window.")
							sleep(30)
							talk_to(usr,"If you ever want to access this information at any time you can press the help button using the charms menu(right hand side of screen)")
							return
				interacted()
					switch(usr.tutorial)
						if(1)
							usr.tutorial+=1
							if(usr.chat_open==FALSE)
								alert(usr,"Hello [usr],\n I see that your chat is closed. Allow me to open it for you!","Hello!")
								sleep(5)
								usr.open_chat()
								winset(usr,"default.map1","focus=true")
								talk_to(usr,"Good, now you have your chat open.")
							else
								talk_to(usr,"Good, you already have your chat open.")
							sleep(20)
							talk_to(usr,"Most NPC's in the game will talk to you like a regular player. So keep your chat window open when you talk to them.")
							sleep(10)
							talk_to(usr,"If you want a quick tutorial just walk up to me and press space to talk to me. If you do not want a tutorial just walk down the hallway and into the world!")
							return
						if(2)
							usr.tutorial+=1
							talk_to(usr,"You can interact with most things in the world by walking up to them and pressing space..")
							return
						if(3)
							if(usr.running)
								usr.tutorial+=1
								talk_to(usr,"Good! now you know how to run around.")
							else
								talk_to(usr,"You can press R to toggle between running or walking.")
								sleep(15)
								talk_to(usr,"Try toggling it on.")
								return
						if(4)
						//							usr.tutorial+=1
							talk_to(usr,"You can press the A key to perform basic attacks.")
							sleep(15)
							talk_to(usr,"Try attacking me!")
							return
						if(5)
							usr.tutorial+=0.5
							talk_to(usr,"Good!")
							sleep(10)
							talk_to(usr,"Quick Tip : You can use Z to auto target nearby mobs")
						if(5.5)
							usr.tutorial+=0.5
							talk_to(usr,"That's all I have to show you..so....Head down that little hallway and go to the next guy, He can show you some more.")
							sleep(20)
							talk_to(usr,"Cya!")
							return
			npc2
				name="Tutorial NPC 2"
				interacted()
					switch(usr.tutorial)
						if(6)
							usr.tutorial+=1
							if(usr.chat_open==FALSE)
								alert(usr,"Hello [usr],\n I see that your chat is closed. Allow me to open it for you!","Hello!")
								sleep(5)
								usr.open_chat()
								winset(usr,"default.map1","focus=true")
								talk_to(usr,"Good, now you have your chat open.")
							else
								talk_to(usr,"Good, you already have your chat open.")
							sleep(20)
							talk_to(usr,"There are a variety of ways to get stronger, but the simplest is to simply train your body and spirit!")
						if(7)
							usr.tutorial+=1
							sleep(5)
							if(charactersheet_open==FALSE)
								usr.toggle_charactersheet()
								winset(usr,"default.map1","focus=true")
								talk_to(usr,"Good, now you have your character status window open.")
							sleep(5)
							talk_to(usr,"You can access this dialogue using the charms on the right of the screen.")
							sleep(5)
							talk_to(usr,"As you train your body, your ability will grow - you can check this by looking at your character's status.")
							return
						if(8)
							if(usr.level<2)
								talk_to(usr,"I want you to reach level 2 by training.")
								sleep(10)
								talk_to(usr,"There are several ways to train..")
								sleep(10)
								talk_to(usr,"You can perform speed training to increase your agility..")
								sleep(10)
								talk_to(usr,"You can practice strength techniques or train with combat dummies to increase your strength.")
								sleep(10)
								talk_to(usr,"You can practice magic techniques or meditate to increase your intelligence and awareness.")
								sleep(10)
								talk_to(usr,"You can increase your endurance by constantly putting strain on your body.")
								sleep(10)
								talk_to(usr,"You can increase your willpower by defeating your enemies and recovering from mortal wounds.")
							if(usr.level>=2)
								talk_to(usr,"Good job, you reached level 2!")
								usr.tutorial++
								sleep(10)
								talk_to(usr,"You can also increase your ability by completing relevant quests/tasks..")
						if(9)
							usr.tutorial++
							talk_to(usr,"Quests are usually found by talking to various NPC's..")
							sleep(5)
							talk_to(usr,"An example is this : You have just accepted a simple quest to talk to me again.")
							usr.client.show_notify("Quest Accepted : Tutorial Quest<br/>\"Talk to the NPC again to finish this quest\"","quest",30)
						if(10)
							talk_to(usr,"Good job, now you just finished the quest, you would get any relevant exp from that task now..")
							usr.tutorial++
							usr.client.show_notify("Quest Completed : Tutorial Quest<br/><br/><font color=yellow>Reward : (none)","quest",30)
						if(11)
							talk_to(usr,"<b>To pickup items you find on your journey : Double Click them. To drop items, drag them off your inventory. To use an item, double click it in in your inventory.</b>")
							usr.tutorial++
							talk_to(usr,"Ok, Now you just need to head down the path to the next guy. Good luck!")

			npc3
				name="Tutorial NPC 3"
				interacted()
					switch(usr.tutorial)
						if(12)
							talk_to(usr,"I am going to give you some quick tips on the currency/resource system, So pay attention!")
							usr.tutorial++
						if(13)
							if(resources_open==FALSE)
								usr.toggle_resources()
								winset(usr,"default.map1","focus=true")
								talk_to(usr,"Good, now you have your resources window open.")
							usr.tutorial++
							talk_to(usr,"The first thing you will notice is that there are two pieces of currency.")
						if(14)
							usr.tutorial++
							talk_to(usr,"Currency in this game is based on Sengoku era japan")
							sleep(10)
							talk_to(usr,"Effectively 1 Ryo is equal to 2000 Mon. Kinda like how 1 US dollar is worth 100 cents in real life.")
							sleep(20)
							talk_to(usr,"1 Mon is roughly equal to 1 dollar in real life. It is said that one ryo is enough to feed a man for year..")
						if(15)
							usr.tutorial++
							talk_to(usr,"Natural Resources in this game are fairly simple to understand.")
							sleep(10)
							talk_to(usr,"To gain wood, you chop down trees(attack them)")
						if(16)
							usr.tutorial++
							talk_to(usr,"To gain ore and stone, you go to a mine and dig them up(interact with them)")
							sleep(20)
							talk_to(usr,"To gain clay, you need to find clay pits and gather clay(interact with them)")
					//talk_to(usr,"Sorry, but that is the end of the tutorial until the game develops more features :( \n\n just proceed down the pathway to enter the world, good luck!")
						if(17)
							usr.tutorial++
							talk_to(usr,"Well thats about all I have to tell you.")
							sleep(10)
							talk_to(usr,"Head to the last NPC for info on how to use those natural resources.")
			npc4
				name="Tutorial NPC 4"
				interacted()
					switch(usr.tutorial)
						if(18)
							talk_to(usr,"I am the last NPC. I am going to tell you about crafting and construction.")
							usr.tutorial++
						if(19)
							if(construct_open==FALSE)
								usr.toggle_construct()
								winset(usr,"default.map1","focus=true")
								talk_to(usr,"Good, now you have your construction panel open.")
							usr.tutorial++
							talk_to(usr,"First thing to remember : Construction is restricted by the national government to housing districts. Make sure you are in one before trying to construct something!")
						if(20)
							usr.tutorial++
							talk_to(usr,"All you need to do to construct an object is click on it when in a housing district.")
							sleep(10)
							talk_to(usr,"Some objects - such as campfires - can be constructed anywhere.")
						if(21)
							usr.tutorial++
							talk_to(usr,"Crafting is also very simple.")
							sleep(10)
							talk_to(usr,"All you need to do is construct a crafting bench then interact with it to bring up the crafting panel")
							sleep(10)
							talk_to(usr,"Then just click on the recipe you want, make sure you have the required ingredients and click craft!")
						if(22)
							talk_to(usr,"Well thats about all I have to tell you, head down the path to enter the world.")
							sleep(10)
							talk_to(usr,"Have fun!")

				//	talk_to(usr,"Sorry, but that is the end of the tutorial until the game develops more features :( \n\n just proceed down the pathway to enter the world, good luck!")
