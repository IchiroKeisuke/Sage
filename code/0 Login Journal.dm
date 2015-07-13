var
	list
		online_players=list()
mob
	var
		points=10

	proc
		sign_in()
			world << "<font color=yellow>[src] has signed in."
			online_players+=src

		sign_out()
			world << "<font color=yellow>[src] has signed out."
			online_players-=src
		respawn()
			src.loc=locate(15,15,1)
	Login()
		sign_in()
		respawn()
	Logout()
		sign_out()