mob
	var
		chat_type="local"

mob/verb/chat(T as text)
	set hidden=1
	set name="chat"
	if(chat_type=="local")
		local_chat(T)
	else
		global_chat(T)

mob/verb/toggle_chat()
	set hidden=1
	switch(chat_type)
		if("local")
			chat_type="global"
		else
			chat_type="local"
	src << "<b><font color=yellow>Chat type set to [chat_type]."

mob/verb/local_chat(T as text)
	set hidden = 1
	set name = "local_chat"
	view() << "<font color=teal>[usr] says: \"[html_encode(T)]\"</font>"

mob/verb/global_chat(T as text)
	set hidden = 1
	set name = "global_chat"
	online_players << "<font color=green>OOC - [usr]: \"[html_encode(T)]\"</font>"
