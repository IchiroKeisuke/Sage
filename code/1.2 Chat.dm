mob/verb/local_chat(T as text)
	set hidden = 1
	set name = "local_chat"
	view() << "<font color=teal>[usr] says: \"[html_encode(T)]\"</font>"

mob/verb/global_chat(T as text)
	set hidden = 1
	set name = "global_chat"
	online_players << "<font color=green>OOC - [usr]: \"[html_encode(T)]\"</font>"



