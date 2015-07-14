world
	New()
		..()
//		spawn(2)system_text("Initializing world..")
//		spawn(3)system_text("Preparing to generate turf edges : Brace for freezeup in 3 seconds..")
//		spawn(4)system_text("Preparing to generate turf edges : Brace for freezeup in 2 seconds..")
//		spawn(5)system_text("Preparing to generate turf edges : Brace for freezeup in 1 seconds..")
//		spawn(5)system_text("Preparing to generate turf edges : Brace for freezeup..")
		spawn(6)
//			system_text("Generating Turf Edges..")
			generate_edging()
	//		system_text("Turf Edges Generated!")
	//		spawn(10)
		//	system_text("Clearing Screen..")
	//		spawn(30)
		//	world << output(null,"Main.output1")
world
	proc
		system_text(var/txt="")
			if(txt=="")
				return
			else
				world << "<font color=#990000><b><u>System</u>:[txt]"
		generate_edging()
//			set background=1
			var/count=0
			for(var/turf/T in world)
				if(T.edge_state!="")
					T.create_edging(T)
					count++
					if(count==100)
						count=0
						sleep(1)