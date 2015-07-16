var
	list/registered_users=list()
	num_of_users=0
mob/proc
	get_who_list()
		for(var/mob/A in registered_users)
			src << "[A]"
		src << "<u>There are [num_of_users] users online."

world
	fps=24
	name="SAGE"
	status="Open Testing Session"
	hub="IchiroKeisuke.Sage"
	view="19x11"
	icon_size=32
	mob=/mob/character
client
//	control_freak=1
	mouse_pointer_icon='RPG_cursor.dmi'
#define DEBUG
mob
	Login()
		..()
		src.icon=null
		src.register_login()
		src.spawn_character()
	Logout()
		..()
		usr.register_logout()
	proc
		spawn_character()
			src.loc=locate(10,7,1)
		mechanics()
			src.create_inventory()
			src.create_charactersheet()
			src.create_HUD()
			spawn(0)src.init_basic_construction_tiles()
			spawn(1)src.get_skills()
			spawn(2)AI_activation_loop()
			spawn(5)regen()
		login_message()
			var/B=usr.popup("<head><title>The following is a In-Development ALPHA</title></head>","Welcome to Sage! <br/><font color=yellow>Expect bugs!</font color=yellow><br/>This game is far from completion and you should not expect a smooth experience at this point in time! Please approach the game knowing that - in time - the game will improve and mature. <br>Thank you!<br>-IchiroKeisuke(Main Developer)<br/>")
			usr << browse(B,"window=Welcome2;size=450x325;titlebar=1;border=0;can_close=0;can_resize=0;can_minimize=0;")
			usr.popup_response()
			usr << browse(null,"window=Welcome2")
		register_login()
//			usr << 'Intro.wma'
//			usr << sound(null)
		//	usr << 'MainMenuButton.wav'
			src.toggle_fullscreen()
			spawn(0)src.simplefadein(10,20)
			usr.play_music('MenuLoop.ogg')
			src.song.volume=0
			src.refresh_music()
			spawn(0)src.fadein_music()
			src.can_move-=1
			registered_users+=src
			num_of_users++
			src << "<font color=yellow><b><u>System:</u></b>[usr.name] has logged in."
		register_logout()
			registered_users-=src
			num_of_users--
			src << "<font color=yellow><b><u>System:</u></b>[usr.name] has logged out."
			del src