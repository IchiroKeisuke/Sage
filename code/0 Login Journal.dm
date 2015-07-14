var
	list
		online_players=list()
mob
	proc

//sign_in/out notify procs are there for keeping track of the player.
//things like login messages, lists of players (like guilds) ect are handled here at login time.

		sign_in_notify()
			world << "<font color=yellow>[src] has signed in."
			online_players+=src
		sign_out_notify()
			world << "<font color=yellow>[src] has signed out."
			online_players-=src

//sign_in/out_logic procs handle the majority of the heavy lifting at login time.


		sign_in_logic()
			src.add_nametag()	//this should be changed once a main menu is created.
			respawn()
		sign_out_logic()

		sign_in()
			sign_in_notify()
			sign_in_logic()
		sign_out()
			sign_out_notify()
			sign_out_logic()
		respawn()
			src.loc=locate(15,15,1)
	Login()
		sign_in()
	Logout()
		sign_out()